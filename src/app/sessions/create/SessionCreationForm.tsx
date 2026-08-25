"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useEffect, useRef, useState } from "react";

import styles from "./page.module.css";

type CategoryOption = {
  id: number;
  title: string;
};

type SubjectOption = {
  id: number;
  title: string;
  categories: CategoryOption[];
};

type SessionCreationFormProps = {
  subjects: SubjectOption[];
  defaultSubjectId: number | null;
};

const ACCURACY_PERCENTAGES = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
const GENERIC_ERROR_MESSAGE = "Something went wrong. Please try again.";
const ZERO_QUESTION_ERROR =
  "The number of Questions must be > 0 in order to start a Session.";

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

function getResponseQuestionCount(body: unknown): number | null {
  if (
    typeof body !== "object" ||
    body === null ||
    !("questionCount" in body) ||
    typeof body.questionCount !== "number" ||
    !Number.isInteger(body.questionCount) ||
    body.questionCount < 0
  ) {
    return null;
  }

  return body.questionCount;
}

function getResponseSessionId(body: unknown): number | null {
  if (
    typeof body !== "object" ||
    body === null ||
    !("sessionId" in body) ||
    typeof body.sessionId !== "number" ||
    !Number.isSafeInteger(body.sessionId) ||
    body.sessionId <= 0
  ) {
    return null;
  }

  return body.sessionId;
}

export function SessionCreationForm({
  subjects,
  defaultSubjectId,
}: SessionCreationFormProps) {
  const router = useRouter();
  const [subjectId, setSubjectId] = useState<number | null>(defaultSubjectId);
  const [askAllQuestions, setAskAllQuestions] = useState(false);
  const [selectedCategoryIds, setSelectedCategoryIds] = useState<number[]>([]);
  const [accuracyOperator, setAccuracyOperator] = useState<"lte" | "gte">(
    "lte",
  );
  const [accuracyPercent, setAccuracyPercent] = useState(50);
  const [questionCount, setQuestionCount] = useState<number | null>(
    defaultSubjectId === null ? 0 : null,
  );
  const [isUpdatingCount, setIsUpdatingCount] = useState(false);
  const [previewError, setPreviewError] = useState<string | null>(null);
  const [startError, setStartError] = useState<string | null>(null);
  const [isStartingSession, setIsStartingSession] = useState(false);
  const startRequestPending = useRef(false);

  const selectedSubject =
    subjects.find((subject) => subject.id === subjectId) ?? null;

  useEffect(() => {
    if (subjectId === null) {
      return;
    }

    const controller = new AbortController();

    async function updateQuestionCount() {
      setIsUpdatingCount(true);
      setQuestionCount(null);
      setPreviewError(null);
      setStartError(null);

      const filters = askAllQuestions
        ? { askAllQuestions: true }
        : {
            askAllQuestions: false,
            categoryIds: selectedCategoryIds,
            accuracyOperator,
            accuracyPercent,
          };

      try {
        const response = await fetch("/api/sessions/preview", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ subjectId, filters }),
          signal: controller.signal,
        });
        const responseBody: unknown = await response.json().catch(() => null);

        if (response.status === 401) {
          router.replace("/");
          return;
        }

        if (!response.ok) {
          setPreviewError(
            getResponseErrorMessage(responseBody) ?? GENERIC_ERROR_MESSAGE,
          );
          return;
        }

        const nextQuestionCount = getResponseQuestionCount(responseBody);

        if (nextQuestionCount === null) {
          setPreviewError(GENERIC_ERROR_MESSAGE);
          return;
        }

        setQuestionCount(nextQuestionCount);
      } catch (error) {
        if (error instanceof Error && error.name === "AbortError") {
          return;
        }

        setPreviewError(GENERIC_ERROR_MESSAGE);
      } finally {
        if (!controller.signal.aborted) {
          setIsUpdatingCount(false);
        }
      }
    }

    void updateQuestionCount();

    return () => controller.abort();
  }, [
    accuracyOperator,
    accuracyPercent,
    askAllQuestions,
    router,
    selectedCategoryIds,
    subjectId,
  ]);

  function toggleCategory(categoryId: number) {
    setSelectedCategoryIds((currentIds) =>
      currentIds.includes(categoryId)
        ? currentIds.filter((currentId) => currentId !== categoryId)
        : [...currentIds, categoryId],
    );
  }

  async function startSession() {
    if (startRequestPending.current) {
      return;
    }

    setStartError(null);

    if (isUpdatingCount) {
      setStartError("Please wait for the Question count to finish updating.");
      return;
    }

    if (previewError || questionCount === null) {
      setStartError("The Question count could not be confirmed.");
      return;
    }

    if (questionCount === 0) {
      setStartError(ZERO_QUESTION_ERROR);
      return;
    }

    if (subjectId === null) {
      setStartError("Select a Subject before starting a Session.");
      return;
    }

    const filters = askAllQuestions
      ? { askAllQuestions: true }
      : {
          askAllQuestions: false,
          categoryIds: selectedCategoryIds,
          accuracyOperator,
          accuracyPercent,
        };

    startRequestPending.current = true;
    setIsStartingSession(true);
    let didStartSession = false;

    try {
      const response = await fetch("/api/sessions", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ subjectId, filters }),
      });
      const responseBody: unknown = await response.json().catch(() => null);

      if (response.status === 401) {
        router.replace("/");
        return;
      }

      if (!response.ok) {
        setStartError(
          getResponseErrorMessage(responseBody) ?? GENERIC_ERROR_MESSAGE,
        );
        return;
      }

      const sessionId = getResponseSessionId(responseBody);

      if (sessionId === null) {
        setStartError(GENERIC_ERROR_MESSAGE);
        return;
      }

      didStartSession = true;
      router.push(`/sessions/${sessionId}`);
    } catch {
      setStartError(GENERIC_ERROR_MESSAGE);
    } finally {
      if (!didStartSession) {
        startRequestPending.current = false;
        setIsStartingSession(false);
      }
    }
  }

  return (
    <main className={styles.main}>
      <div className={styles.introduction}>
        <p className={styles.eyebrow}>Session Creation</p>
        <h1>Create a new Session</h1>
        <p>Choose the Questions you want to practice.</p>
      </div>

      <section className={styles.countCard} aria-labelledby="question-count">
        <p>Total Questions to be asked</p>
        <p
          id="question-count"
          className={styles.questionCount}
          aria-live="polite"
          aria-busy={isUpdatingCount}
        >
          {questionCount === null ? "…" : questionCount}
          <span>{questionCount === 1 ? " Question" : " Questions"}</span>
        </p>
      </section>

      <section className={styles.filterCard} aria-labelledby="filters-heading">
        <div className={styles.cardHeading}>
          <p>Session options</p>
          <h2 id="filters-heading">Choose your Questions</h2>
        </div>

        <div className={styles.field}>
          <label htmlFor="subject">Subject</label>
          <select
            id="subject"
            value={subjectId ?? ""}
            disabled={subjects.length === 0}
            onChange={(event) => {
              setSubjectId(Number(event.target.value));
              setSelectedCategoryIds([]);
            }}
          >
            {subjects.length === 0 ? (
              <option value="">No Subjects available</option>
            ) : null}
            {subjects.map((subject) => (
              <option key={subject.id} value={subject.id}>
                {subject.title}
              </option>
            ))}
          </select>
        </div>

        <label className={styles.askAllOption}>
          <input
            type="checkbox"
            checked={askAllQuestions}
            onChange={(event) => setAskAllQuestions(event.target.checked)}
          />
          <span>
            <strong>Ask All Questions</strong>
            <small>Ignore Category and Question Accuracy filters.</small>
          </span>
        </label>

        {!askAllQuestions ? (
          <div className={styles.additionalFilters}>
            {selectedSubject && selectedSubject.categories.length > 0 ? (
              <fieldset className={styles.categoryFieldset}>
                <legend>Categories</legend>
                <p>
                  Select any Categories to limit the Questions. Leave all
                  unselected to include every Category.
                </p>
                <div className={styles.categoryList}>
                  {selectedSubject.categories.map((category) => (
                    <label className={styles.categoryOption} key={category.id}>
                      <input
                        type="checkbox"
                        checked={selectedCategoryIds.includes(category.id)}
                        onChange={() => toggleCategory(category.id)}
                      />
                      <span>{category.title}</span>
                    </label>
                  ))}
                </div>
              </fieldset>
            ) : null}

            <fieldset className={styles.accuracyFieldset}>
              <legend>Question Accuracy</legend>
              <div className={styles.accuracyControls}>
                <span aria-hidden="true">Question Accuracy:</span>
                <label>
                  <span className={styles.visuallyHidden}>Comparison</span>
                  <select
                    value={accuracyOperator}
                    onChange={(event) => {
                      const nextOperator = event.target.value;

                      if (nextOperator === "lte" || nextOperator === "gte") {
                        setAccuracyOperator(nextOperator);
                      }
                    }}
                  >
                    <option value="lte">≤</option>
                    <option value="gte">≥</option>
                  </select>
                </label>
                <label>
                  <span className={styles.visuallyHidden}>Percentage</span>
                  <select
                    value={accuracyPercent}
                    onChange={(event) =>
                      setAccuracyPercent(Number(event.target.value))
                    }
                  >
                    {ACCURACY_PERCENTAGES.map((percentage) => (
                      <option value={percentage} key={percentage}>
                        {percentage}%
                      </option>
                    ))}
                  </select>
                </label>
              </div>
            </fieldset>
          </div>
        ) : null}

        <div className={styles.messageArea} aria-live="assertive">
          {previewError ? <p className={styles.error}>{previewError}</p> : null}
          {startError ? <p className={styles.error}>{startError}</p> : null}
        </div>
      </section>

      <div className={styles.actions}>
        <Link href="/landing" className={styles.homeButton}>
          Home
        </Link>
        <button
          type="button"
          className={styles.startButton}
          disabled={isStartingSession}
          onClick={() => void startSession()}
        >
          {isStartingSession ? "Starting Session…" : "Start Session"}
        </button>
      </div>
    </main>
  );
}
