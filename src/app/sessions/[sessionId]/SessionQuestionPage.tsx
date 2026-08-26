"use client";

import { useRouter } from "next/navigation";
import { useEffect, useRef, useState } from "react";

import styles from "./page.module.css";

type SessionPageData = {
  sessionDetails: {
    subject: string;
    categories: string[];
  };
  currentQuestion: {
    questionId: number;
    questionText: string;
  };
  session: {
    roundNumber: number;
    questionsAnsweredCorrectly: number;
    questionsTotal: number;
  };
};

type SessionQuestionPageProps = {
  sessionId: string;
};

type SkipResponseData = Pick<SessionPageData, "currentQuestion" | "session">;

type GuessResponseData = {
  previous: {
    answerText: string;
    correct: boolean;
  };
  currentQuestion: SessionPageData["currentQuestion"];
  session: SessionPageData["session"];
};

type PreviousSubmission =
  | {
      status: "result";
      guessText: string;
      answerText: string;
      correct: boolean;
    }
  | { status: "error"; message: string };

const GENERIC_ERROR_MESSAGE = "Something went wrong. Please try again.";
const GENERIC_GUESS_ERROR_MESSAGE =
  "An unexpected server error occurred. Reloading a new question.";

function getResponseErrorMessage(body: unknown): string | null {
  if (typeof body !== "object" || body === null || !("error" in body)) {
    return null;
  }

  const error = body.error;

  if (typeof error !== "object" || error === null || !("message" in error)) {
    return null;
  }

  return typeof error.message === "string" ? error.message : null;
}

function isPositiveInteger(value: unknown): value is number {
  return typeof value === "number" && Number.isSafeInteger(value) && value > 0;
}

function isNonNegativeInteger(value: unknown): value is number {
  return typeof value === "number" && Number.isSafeInteger(value) && value >= 0;
}

function getSessionPageData(body: unknown): SessionPageData | null {
  if (
    typeof body !== "object" ||
    body === null ||
    !("sessionDetails" in body) ||
    typeof body.sessionDetails !== "object" ||
    body.sessionDetails === null ||
    !("subject" in body.sessionDetails) ||
    typeof body.sessionDetails.subject !== "string" ||
    !("categories" in body.sessionDetails) ||
    !Array.isArray(body.sessionDetails.categories) ||
    !body.sessionDetails.categories.every(
      (category) => typeof category === "string",
    ) ||
    !("currentQuestion" in body) ||
    typeof body.currentQuestion !== "object" ||
    body.currentQuestion === null ||
    !("questionId" in body.currentQuestion) ||
    !isPositiveInteger(body.currentQuestion.questionId) ||
    !("questionText" in body.currentQuestion) ||
    typeof body.currentQuestion.questionText !== "string" ||
    !("session" in body) ||
    typeof body.session !== "object" ||
    body.session === null ||
    !("roundNumber" in body.session) ||
    !isPositiveInteger(body.session.roundNumber) ||
    !("questionsAnsweredCorrectly" in body.session) ||
    !isNonNegativeInteger(body.session.questionsAnsweredCorrectly) ||
    !("questionsTotal" in body.session) ||
    !isPositiveInteger(body.session.questionsTotal) ||
    body.session.questionsAnsweredCorrectly > body.session.questionsTotal
  ) {
    return null;
  }

  return {
    sessionDetails: {
      subject: body.sessionDetails.subject,
      categories: body.sessionDetails.categories,
    },
    currentQuestion: {
      questionId: body.currentQuestion.questionId,
      questionText: body.currentQuestion.questionText,
    },
    session: {
      roundNumber: body.session.roundNumber,
      questionsAnsweredCorrectly: body.session.questionsAnsweredCorrectly,
      questionsTotal: body.session.questionsTotal,
    },
  };
}

function getSkipResponseData(body: unknown): SkipResponseData | null {
  if (
    typeof body !== "object" ||
    body === null ||
    !("currentQuestion" in body) ||
    typeof body.currentQuestion !== "object" ||
    body.currentQuestion === null ||
    !("questionId" in body.currentQuestion) ||
    !isPositiveInteger(body.currentQuestion.questionId) ||
    !("questionText" in body.currentQuestion) ||
    typeof body.currentQuestion.questionText !== "string" ||
    !("session" in body) ||
    typeof body.session !== "object" ||
    body.session === null ||
    !("roundNumber" in body.session) ||
    !isPositiveInteger(body.session.roundNumber) ||
    !("questionsAnsweredCorrectly" in body.session) ||
    !isNonNegativeInteger(body.session.questionsAnsweredCorrectly) ||
    !("questionsTotal" in body.session) ||
    !isPositiveInteger(body.session.questionsTotal) ||
    body.session.questionsAnsweredCorrectly > body.session.questionsTotal
  ) {
    return null;
  }

  return {
    currentQuestion: {
      questionId: body.currentQuestion.questionId,
      questionText: body.currentQuestion.questionText,
    },
    session: {
      roundNumber: body.session.roundNumber,
      questionsAnsweredCorrectly: body.session.questionsAnsweredCorrectly,
      questionsTotal: body.session.questionsTotal,
    },
  };
}

function getGuessResponseData(body: unknown): GuessResponseData | null {
  if (
    typeof body !== "object" ||
    body === null ||
    !("sessionCompleted" in body) ||
    body.sessionCompleted !== false ||
    !("previous" in body) ||
    typeof body.previous !== "object" ||
    body.previous === null ||
    !("answerText" in body.previous) ||
    typeof body.previous.answerText !== "string" ||
    !("correct" in body.previous) ||
    typeof body.previous.correct !== "boolean"
  ) {
    return null;
  }

  const questionAndSession = getSkipResponseData(body);

  return questionAndSession
    ? {
        previous: {
          answerText: body.previous.answerText,
          correct: body.previous.correct,
        },
        ...questionAndSession,
      }
    : null;
}

function isSessionCompletedResponse(body: unknown): boolean {
  return (
    typeof body === "object" &&
    body !== null &&
    "sessionCompleted" in body &&
    body.sessionCompleted === true
  );
}

export function SessionQuestionPage({ sessionId }: SessionQuestionPageProps) {
  const router = useRouter();
  const guessInputRef = useRef<HTMLInputElement>(null);
  const [pageData, setPageData] = useState<SessionPageData | null>(null);
  const [guess, setGuess] = useState("");
  const [previousSubmission, setPreviousSubmission] =
    useState<PreviousSubmission | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [isSkipping, setIsSkipping] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    const controller = new AbortController();

    async function loadSession() {
      setPageData(null);
      setErrorMessage(null);
      setIsLoading(true);

      try {
        const response = await fetch(
          `/api/sessions/${encodeURIComponent(sessionId)}`,
          {
            cache: "no-store",
            signal: controller.signal,
          },
        );
        const responseBody: unknown = await response.json().catch(() => null);

        if (response.status === 401) {
          router.replace("/");
          return;
        }

        if (!response.ok) {
          setErrorMessage(
            getResponseErrorMessage(responseBody) ?? GENERIC_ERROR_MESSAGE,
          );
          return;
        }

        const nextPageData = getSessionPageData(responseBody);

        if (!nextPageData) {
          setErrorMessage(GENERIC_ERROR_MESSAGE);
          return;
        }

        setPageData(nextPageData);
      } catch (error) {
        if (error instanceof Error && error.name === "AbortError") {
          return;
        }

        setErrorMessage(GENERIC_ERROR_MESSAGE);
      } finally {
        if (!controller.signal.aborted) {
          setIsLoading(false);
        }
      }
    }

    void loadSession();

    return () => controller.abort();
  }, [router, sessionId]);

  async function reloadSessionAfterError(): Promise<void> {
    try {
      const response = await fetch(
        `/api/sessions/${encodeURIComponent(sessionId)}`,
        { cache: "no-store" },
      );
      const responseBody: unknown = await response.json().catch(() => null);

      if (response.status === 401) {
        router.replace("/");
        return;
      }

      if (!response.ok) {
        setPageData(null);
        setErrorMessage(
          getResponseErrorMessage(responseBody) ?? GENERIC_ERROR_MESSAGE,
        );
        return;
      }

      const reloadedPageData = getSessionPageData(responseBody);

      if (reloadedPageData) {
        setPageData(reloadedPageData);
        setGuess("");
      }
    } catch {
      // Keep the currently displayed state and the original action error when
      // the recovery request itself cannot be completed.
    }
  }

  async function recoverSessionAfterGuessError(
    submissionErrorMessage: string,
  ): Promise<void> {
    try {
      const response = await fetch(
        `/api/sessions/${encodeURIComponent(sessionId)}`,
        { cache: "no-store" },
      );
      const responseBody: unknown = await response.json().catch(() => null);

      if (response.status === 401) {
        setGuess("");
        router.replace("/");
        return;
      }

      if (!response.ok) {
        const recoveryErrorMessage =
          getResponseErrorMessage(responseBody) ?? GENERIC_ERROR_MESSAGE;
        setPreviousSubmission({
          status: "error",
          message: `${submissionErrorMessage} Unable to reload the Session: ${recoveryErrorMessage}`,
        });
        return;
      }

      const reloadedPageData = getSessionPageData(responseBody);

      if (!reloadedPageData) {
        setPreviousSubmission({
          status: "error",
          message: `${submissionErrorMessage} Unable to reload the Session.`,
        });
        return;
      }

      setPageData(reloadedPageData);
      guessInputRef.current?.focus();
    } catch {
      setPreviousSubmission({
        status: "error",
        message: `${submissionErrorMessage} Unable to reload the Session.`,
      });
    }
  }

  async function submitCurrentGuess(): Promise<void> {
    if (!pageData || isSubmitting || isSkipping) {
      return;
    }

    const submittedGuess = guess;
    setIsSubmitting(true);
    setErrorMessage(null);

    try {
      const response = await fetch(
        `/api/sessions/${encodeURIComponent(sessionId)}/guesses`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            questionId: pageData.currentQuestion.questionId,
            guess: submittedGuess,
          }),
        },
      );
      const responseBody: unknown = await response.json().catch(() => null);

      if (response.status === 401) {
        setGuess("");
        router.replace("/");
        return;
      }

      if (!response.ok) {
        const submissionErrorMessage =
          getResponseErrorMessage(responseBody) ?? GENERIC_GUESS_ERROR_MESSAGE;
        setGuess("");
        setPreviousSubmission({
          status: "error",
          message: submissionErrorMessage,
        });
        await recoverSessionAfterGuessError(submissionErrorMessage);
        return;
      }

      if (isSessionCompletedResponse(responseBody)) {
        router.replace(`/sessions/${encodeURIComponent(sessionId)}/complete`);
        return;
      }

      const guessResponseData = getGuessResponseData(responseBody);

      if (!guessResponseData) {
        setGuess("");
        setPreviousSubmission({
          status: "error",
          message: GENERIC_GUESS_ERROR_MESSAGE,
        });
        await recoverSessionAfterGuessError(GENERIC_GUESS_ERROR_MESSAGE);
        return;
      }

      setPageData((currentPageData) =>
        currentPageData
          ? {
              ...currentPageData,
              currentQuestion: guessResponseData.currentQuestion,
              session: guessResponseData.session,
            }
          : currentPageData,
      );
      setGuess("");
      setPreviousSubmission({
        status: "result",
        guessText: submittedGuess,
        answerText: guessResponseData.previous.answerText,
        correct: guessResponseData.previous.correct,
      });
      guessInputRef.current?.focus();
    } catch {
      setGuess("");
      setPreviousSubmission({
        status: "error",
        message: GENERIC_GUESS_ERROR_MESSAGE,
      });
      await recoverSessionAfterGuessError(GENERIC_GUESS_ERROR_MESSAGE);
    } finally {
      setIsSubmitting(false);
    }
  }

  async function skipCurrentQuestion(): Promise<void> {
    if (!pageData || isSkipping) {
      return;
    }

    setIsSkipping(true);
    setErrorMessage(null);

    try {
      const response = await fetch(
        `/api/sessions/${encodeURIComponent(sessionId)}/skip`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            questionId: pageData.currentQuestion.questionId,
          }),
        },
      );
      const responseBody: unknown = await response.json().catch(() => null);

      if (response.status === 401) {
        router.replace("/");
        return;
      }

      if (!response.ok) {
        setErrorMessage(
          getResponseErrorMessage(responseBody) ?? GENERIC_ERROR_MESSAGE,
        );
        await reloadSessionAfterError();
        return;
      }

      const skipResponseData = getSkipResponseData(responseBody);

      if (!skipResponseData) {
        setErrorMessage(GENERIC_ERROR_MESSAGE);
        await reloadSessionAfterError();
        return;
      }

      setPageData((currentPageData) =>
        currentPageData
          ? {
              ...currentPageData,
              currentQuestion: skipResponseData.currentQuestion,
              session: skipResponseData.session,
            }
          : currentPageData,
      );
      setGuess("");
    } catch {
      setErrorMessage(GENERIC_ERROR_MESSAGE);
      await reloadSessionAfterError();
    } finally {
      setIsSkipping(false);
    }
  }

  if (isLoading) {
    return (
      <main className={styles.main}>
        <p className={styles.loadingMessage}>Loading Session…</p>
      </main>
    );
  }

  if (!pageData) {
    return (
      <main className={styles.main}>
        <section className={styles.errorCard} aria-live="assertive">
          <h1>Unable to display Session</h1>
          <p>{errorMessage ?? GENERIC_ERROR_MESSAGE}</p>
        </section>
      </main>
    );
  }

  return (
    <main className={styles.main}>
      <section className={styles.sessionSummary} aria-label="Session summary">
        <div className={styles.sessionDetails}>
          <div>
            <p>Subject</p>
            <h1>{pageData.sessionDetails.subject}</h1>
          </div>
          {pageData.sessionDetails.categories.length > 0 ? (
            <div>
              <p>Categories</p>
              <p>{pageData.sessionDetails.categories.join(", ")}</p>
            </div>
          ) : null}
        </div>

        <div className={styles.statusGrid}>
          <div className={styles.roundCard} aria-label="Current round">
            <p>Round</p>
            <p>{pageData.session.roundNumber}</p>
          </div>
          <div className={styles.progressCard} aria-label="Session progress">
            <p>
              <strong>{pageData.session.questionsAnsweredCorrectly}</strong> of{" "}
              <strong>{pageData.session.questionsTotal}</strong> answered
              correctly
            </p>
          </div>
        </div>
      </section>

      {previousSubmission ? (
        <section
          className={styles.previousCard}
          aria-labelledby="previous-heading"
          aria-live={
            previousSubmission.status === "error" ? "assertive" : "polite"
          }
        >
          <p className={styles.eyebrow}>Previous Q&amp;A</p>
          <h2 id="previous-heading">Most recent submission</h2>

          {previousSubmission.status === "error" ? (
            <p className={styles.previousError}>{previousSubmission.message}</p>
          ) : (
            <dl className={styles.previousDetails}>
              <div
                className={
                  previousSubmission.correct
                    ? styles.correctStatus
                    : styles.incorrectStatus
                }
              >
                <dt>Result</dt>
                <dd className={styles.resultText}>
                  <span className={styles.resultIcon} aria-hidden="true">
                    {previousSubmission.correct ? "✓" : "✕"}
                  </span>
                  <span>
                    {previousSubmission.correct ? "Correct" : "Incorrect"}
                  </span>
                </dd>
              </div>
              <div
                className={
                  previousSubmission.correct
                    ? styles.correctStatus
                    : styles.incorrectStatus
                }
              >
                <dt>Your Guess</dt>
                <dd>{previousSubmission.guessText || "(empty)"}</dd>
              </div>
              <div>
                <dt>Correct Answer</dt>
                <dd>{previousSubmission.answerText}</dd>
              </div>
            </dl>
          )}
        </section>
      ) : null}

      <section
        className={styles.questionCard}
        aria-labelledby="question-heading"
      >
        <p className={styles.eyebrow}>Question</p>
        <h2 id="question-heading">{pageData.currentQuestion.questionText}</h2>

        <form
          className={styles.answerForm}
          onSubmit={(event) => {
            event.preventDefault();
            void submitCurrentGuess();
          }}
        >
          <label htmlFor="guess">Your answer</label>
          <input
            ref={guessInputRef}
            id="guess"
            name="guess"
            type="text"
            maxLength={100}
            autoComplete="off"
            placeholder="Type answer here"
            value={guess}
            onChange={(event) => setGuess(event.target.value)}
          />

          {errorMessage ? (
            <p className={styles.actionError} aria-live="assertive">
              {errorMessage}
            </p>
          ) : null}

          <div className={styles.actions}>
            <button
              type="button"
              className={styles.skipButton}
              disabled={isSkipping || isSubmitting}
              onClick={() => void skipCurrentQuestion()}
            >
              {isSkipping ? "Skipping…" : "Skip for now"}
            </button>
            <button
              type="submit"
              className={styles.submitButton}
              disabled={isSubmitting || isSkipping}
            >
              {isSubmitting ? "Submitting…" : "Submit"}
            </button>
          </div>
        </form>
      </section>
    </main>
  );
}
