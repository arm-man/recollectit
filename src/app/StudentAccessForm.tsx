"use client";

import { useRef, useState, type FormEvent } from "react";
import { useRouter } from "next/navigation";
import styles from "./page.module.css";

const MAX_USERNAME_LENGTH = 25;
const WHITESPACE_PATTERN = /\s/u;
const CONTROL_OR_FORMATTING_PATTERN = /[\p{Cc}\p{Cf}]/u;
const INVALID_USERNAME_MESSAGE = "Username fails format or length validation.";
const DUPLICATE_USERNAME_MESSAGE =
  "The Username already exists, please create a different Username.";
const USERNAME_NOT_FOUND_MESSAGE = "That Username does not exist.";
const GENERIC_ERROR_MESSAGE = "Something went wrong. Please try again.";

function getUsernameErrors(username: string, shouldTrim = false): string[] {
  const errors: string[] = [];
  const normalizedUsername = (
    shouldTrim ? username.trim() : username
  ).normalize("NFC");

  if (normalizedUsername.length === 0) {
    errors.push("Username is required.");
  }

  if (Array.from(normalizedUsername).length > MAX_USERNAME_LENGTH) {
    errors.push("The maximum length of the username is 25 characters.");
  }

  if (WHITESPACE_PATTERN.test(normalizedUsername)) {
    errors.push("Username cannot contain whitespace.");
  }

  if (CONTROL_OR_FORMATTING_PATTERN.test(normalizedUsername)) {
    errors.push(
      "Username cannot contain control or invisible formatting characters.",
    );
  }

  return errors;
}

function getResponseErrorCode(body: unknown): string | null {
  if (typeof body !== "object" || body === null || !("error" in body)) {
    return null;
  }

  const error = body.error;

  if (typeof error !== "object" || error === null || !("code" in error)) {
    return null;
  }

  return typeof error.code === "string" ? error.code : null;
}

export function StudentAccessForm() {
  const router = useRouter();
  const isLoggingInRef = useRef(false);
  const isCreatingStudentRef = useRef(false);
  const [loginUsername, setLoginUsername] = useState("");
  const [createUsername, setCreateUsername] = useState("");
  const [hasTouchedLogin, setHasTouchedLogin] = useState(false);
  const [hasTouchedCreate, setHasTouchedCreate] = useState(false);
  const [loginRequestError, setLoginRequestError] = useState<string | null>(
    null,
  );
  const [createRequestError, setCreateRequestError] = useState<string | null>(
    null,
  );
  const [isLoggingIn, setIsLoggingIn] = useState(false);
  const [isCreatingStudent, setIsCreatingStudent] = useState(false);

  const loginErrors = getUsernameErrors(loginUsername);
  const createErrors = getUsernameErrors(createUsername, true);
  const visibleLoginErrors =
    hasTouchedLogin || loginUsername.length > 0 ? loginErrors : [];
  const visibleCreateErrors =
    hasTouchedCreate || createUsername.length > 0 ? createErrors : [];

  async function loginStudent(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setHasTouchedLogin(true);
    setLoginRequestError(null);

    if (loginErrors.length > 0 || isLoggingInRef.current) {
      return;
    }

    isLoggingInRef.current = true;
    setIsLoggingIn(true);

    try {
      const response = await fetch("/api/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: loginUsername }),
      });

      if (response.ok) {
        router.push("/landing");
        return;
      }

      const responseBody: unknown = await response.json().catch(() => null);
      const errorCode = getResponseErrorCode(responseBody);

      if (errorCode === "INVALID_USERNAME") {
        setLoginRequestError(INVALID_USERNAME_MESSAGE);
      } else if (errorCode === "USERNAME_NOT_FOUND") {
        setLoginRequestError(USERNAME_NOT_FOUND_MESSAGE);
      } else {
        setLoginRequestError(GENERIC_ERROR_MESSAGE);
      }
    } catch {
      setLoginRequestError(GENERIC_ERROR_MESSAGE);
    } finally {
      isLoggingInRef.current = false;
      setIsLoggingIn(false);
    }
  }

  async function createStudent(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setHasTouchedCreate(true);
    setCreateRequestError(null);

    if (createErrors.length > 0 || isCreatingStudentRef.current) {
      return;
    }

    isCreatingStudentRef.current = true;
    setIsCreatingStudent(true);

    try {
      const response = await fetch("/api/students", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: createUsername }),
      });

      if (response.ok) {
        router.push("/landing");
        return;
      }

      const responseBody: unknown = await response.json().catch(() => null);
      const errorCode = getResponseErrorCode(responseBody);

      if (errorCode === "INVALID_USERNAME") {
        setCreateRequestError(INVALID_USERNAME_MESSAGE);
      } else if (errorCode === "USERNAME_ALREADY_EXISTS") {
        setCreateRequestError(DUPLICATE_USERNAME_MESSAGE);
      } else {
        setCreateRequestError(GENERIC_ERROR_MESSAGE);
      }
    } catch {
      setCreateRequestError(GENERIC_ERROR_MESSAGE);
    } finally {
      isCreatingStudentRef.current = false;
      setIsCreatingStudent(false);
    }
  }

  return (
    <div className={styles.page}>
      <header className={styles.header}>
        <div className={styles.wordmark} aria-label="Recollect It">
          <span>Recollect</span>
          <span className={styles.wordmarkAccent}>It</span>
        </div>
      </header>

      <main className={styles.main}>
        <div className={styles.introduction}>
          <p className={styles.eyebrow}>Student Access</p>
          <h1>Study what you know. Remember it longer.</h1>
          <p>Recollect It is a free, interactive learning and study tool designed to help you improve your memory and retain what you&apos;ve learned. Through online flashcards and question-and-answer exercises, you can test your knowledge of a variety of subjects, including world and U.S. capitals, literature, famous artists, foreign language vocabulary, or topics you create yourself. Unlike traditional flashcard apps, Recollect It gives you control over your learning experience. Customize which questions appear in each study session and develop your own memory-training strategy using techniques such as spaced repetition or the Leitner System. Practice at your own pace, review your answers, and strengthen your knowledge through active recall and repeated practice—proven techniques for improving long-term retention. Make learning a lifelong habit with Recollect It.</p>
        </div>

        <div className={styles.cards}>
          <section
            className={`${styles.card} ${styles.loginCard}`}
            aria-labelledby="login-heading"
          >
            <div className={styles.cardHeading}>
              <h2 id="login-heading" className={styles.cardLabel}>Returning Student</h2>
              <p>Enter your case-sensitive username to continue.</p>
            </div>

            <form
              className={styles.form}
              onSubmit={loginStudent}
              noValidate
              aria-busy={isLoggingIn}
            >
              <div className={styles.field}>
                <label className={styles.visuallyHidden} htmlFor="login-username">Username</label>
                <input
                  id="login-username"
                  name="loginUsername"
                  type="text"
                  placeholder="Username"
                  autoComplete="username"
                  autoCapitalize="none"
                  spellCheck={false}
                  required
                  value={loginUsername}
                  aria-invalid={
                    visibleLoginErrors.length > 0 || loginRequestError !== null
                  }
                  aria-describedby="login-errors"
                  onBlur={() => setHasTouchedLogin(true)}
                  onChange={(event) => {
                    setLoginUsername(event.target.value);
                    setLoginRequestError(null);
                  }}
                />
                <div
                  id="login-errors"
                  className={styles.messageArea}
                  aria-live="polite"
                >
                  {visibleLoginErrors.map((error) => (
                    <p className={styles.error} key={error}>
                      {error}
                    </p>
                  ))}
                  {loginRequestError ? (
                    <p className={styles.error}>{loginRequestError}</p>
                  ) : null}
                </div>
              </div>

              <button
                type="submit"
                disabled={loginErrors.length > 0 || isLoggingIn}
              >
                {isLoggingIn ? "Logging In…" : "Log In"}
              </button>
            </form>
          </section>

          <section
            className={`${styles.card} ${styles.createCard}`}
            aria-labelledby="create-heading"
          >
            <div className={styles.cardHeading}>
              <h2 id="create-heading" className={styles.cardLabel}>New Student</h2>
              <p>
                To get started, choose a unique, case-sensitive username. For
                example, &apos;Fred&apos;.
              </p>
            </div>

            <form
              className={styles.form}
              onSubmit={createStudent}
              noValidate
              aria-busy={isCreatingStudent}
            >
              <div className={styles.field}>
                <label className={styles.visuallyHidden} htmlFor="create-username">Username</label>
                <input
                  id="create-username"
                  name="createUsername"
                  type="text"
                  placeholder="Username"
                  autoComplete="username"
                  autoCapitalize="none"
                  spellCheck={false}
                  required
                  value={createUsername}
                  aria-invalid={
                    visibleCreateErrors.length > 0 ||
                    createRequestError !== null
                  }
                  aria-describedby="create-help create-errors"
                  onBlur={() => setHasTouchedCreate(true)}
                  onChange={(event) => {
                    setCreateUsername(event.target.value);
                    setCreateRequestError(null);
                  }}
                />
                <p id="create-help" className={styles.helperText}>
                  Up to 25 characters. No spaces.
                </p>
                <div
                  id="create-errors"
                  className={styles.messageArea}
                  aria-live="assertive"
                >
                  {visibleCreateErrors.map((error) => (
                    <p className={styles.error} key={error}>
                      {error}
                    </p>
                  ))}
                  {createRequestError ? (
                    <p className={styles.error}>{createRequestError}</p>
                  ) : null}
                </div>
              </div>

              <button
                type="submit"
                disabled={createErrors.length > 0 || isCreatingStudent}
              >
                {isCreatingStudent ? "Creating User…" : "Create User"}
              </button>
            </form>
          </section>
        </div>
      </main>
    </div>
  );
}
