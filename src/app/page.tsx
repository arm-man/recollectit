"use client";

import { useState, type FormEvent, type KeyboardEvent } from "react";
import styles from "./page.module.css";

const MAX_USERNAME_LENGTH = 25;
const WHITESPACE_PATTERN = /\s/u;
const CONTROL_OR_FORMATTING_PATTERN = /[\p{Cc}\p{Cf}]/u;

function getUsernameErrors(username: string): string[] {
  const errors: string[] = [];

  if (username.length === 0) {
    errors.push("Username is required.");
  }

  if (Array.from(username.normalize("NFC")).length > MAX_USERNAME_LENGTH) {
    errors.push("The maximum length of the username is 25 characters.");
  }

  if (WHITESPACE_PATTERN.test(username)) {
    errors.push("Username cannot contain whitespace.");
  }

  if (CONTROL_OR_FORMATTING_PATTERN.test(username)) {
    errors.push(
      "Username cannot contain control or invisible formatting characters.",
    );
  }

  return errors;
}

function preventSubmission(event: FormEvent<HTMLFormElement>) {
  event.preventDefault();
}

function preventEnterSubmission(event: KeyboardEvent<HTMLInputElement>) {
  if (event.key === "Enter") {
    event.preventDefault();
  }
}

export default function Home() {
  const [loginUsername, setLoginUsername] = useState("");
  const [createUsername, setCreateUsername] = useState("");
  const [hasTouchedLogin, setHasTouchedLogin] = useState(false);
  const [hasTouchedCreate, setHasTouchedCreate] = useState(false);

  const loginErrors = getUsernameErrors(loginUsername);
  const createErrors = getUsernameErrors(createUsername);
  const visibleLoginErrors =
    hasTouchedLogin || loginUsername.length > 0 ? loginErrors : [];
  const visibleCreateErrors =
    hasTouchedCreate || createUsername.length > 0 ? createErrors : [];

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
          <p>Continue where you left off or choose a username to begin.</p>
        </div>

        <div className={styles.cards}>
          <section
            className={`${styles.card} ${styles.loginCard}`}
            aria-labelledby="login-heading"
          >
            <div className={styles.cardHeading}>
              <p className={styles.cardLabel}>Returning student</p>
              <h2 id="login-heading">Log In</h2>
              <p>Enter your case-sensitive username to continue.</p>
            </div>

            <form
              className={styles.form}
              onSubmit={preventSubmission}
              noValidate
            >
              <div className={styles.field}>
                <label htmlFor="login-username">Username</label>
                <input
                  id="login-username"
                  name="loginUsername"
                  type="text"
                  autoComplete="username"
                  autoCapitalize="none"
                  spellCheck={false}
                  required
                  value={loginUsername}
                  aria-invalid={visibleLoginErrors.length > 0}
                  aria-describedby="login-errors"
                  onBlur={() => setHasTouchedLogin(true)}
                  onChange={(event) => setLoginUsername(event.target.value)}
                  onKeyDown={preventEnterSubmission}
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
                </div>
              </div>

              <button type="submit" disabled={loginErrors.length > 0}>
                Log In
              </button>
            </form>
          </section>

          <section
            className={`${styles.card} ${styles.createCard}`}
            aria-labelledby="create-heading"
          >
            <div className={styles.cardHeading}>
              <p className={styles.cardLabel}>New student</p>
              <h2 id="create-heading">Create User</h2>
              <p>
                To get started, choose a unique, case-sensitive username. Your
                email address is a convenient option.
              </p>
            </div>

            <form
              className={styles.form}
              onSubmit={preventSubmission}
              noValidate
            >
              <div className={styles.field}>
                <label htmlFor="create-username">Username</label>
                <input
                  id="create-username"
                  name="createUsername"
                  type="text"
                  autoComplete="username"
                  autoCapitalize="none"
                  spellCheck={false}
                  required
                  value={createUsername}
                  aria-invalid={visibleCreateErrors.length > 0}
                  aria-describedby="create-help create-errors"
                  onBlur={() => setHasTouchedCreate(true)}
                  onChange={(event) => setCreateUsername(event.target.value)}
                  onKeyDown={preventEnterSubmission}
                />
                <p id="create-help" className={styles.helperText}>
                  Up to 25 characters. No spaces.
                </p>
                <div
                  id="create-errors"
                  className={styles.messageArea}
                  aria-live="polite"
                >
                  {visibleCreateErrors.map((error) => (
                    <p className={styles.error} key={error}>
                      {error}
                    </p>
                  ))}
                </div>
              </div>

              <button type="submit" disabled={createErrors.length > 0}>
                Create User
              </button>
            </form>
          </section>
        </div>
      </main>
    </div>
  );
}
