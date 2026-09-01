# Recollect It Product Specification

## Overview

Recollect It is a mobile-friendly, web-based flashcard application for anyone who wants to memorize or review information.

Primary user goal: review existing knowledge.

Primary product success measure: students study regularly.

## Terminology

- **Student**: the person using Recollect It.
- **Username**: the name used to access a student's data.
- **Question**: a prompt presented to the Student.
- **Primary Answer**: the required correct Answer used for Guess evaluation and displayed to the Student.
- **Alternate Answer**: an optional additional correct Answer used only for Guess evaluation and never displayed to the Student.
- **Guess**: the Student's submitted answer to a Question.
- **Attempt**: one submitted Guess for a Question. Attempts are counted, but individual Guesses and Attempt details are not retained.
- **Subject**: a topic containing Questions, e.g. `World Capitals`.
- **Category**: A subtopic within a Subject, e.g. `Europe`.
- **Session**: a fixed set of Questions from one Subject that continues until every Question has been answered correctly.
- **Question Accuracy**: for a Student, `Correct Attempts / Total Attempts`.
- **Round**: a period during which every Question that was incomplete when the Round began must receive one Attempt.
- **#FutureRelease**: indicates that a requirement may change in a future release; this is for notation only and does not affect the current requirements.

## Student Access

- The initial page is the Log In page, which has two sections, one to log in and another to create a Username.
- During creation, the Username should be limited to 25 characters.
- A Student accesses the application using only a Username.
- Logging in with a valid Username provides access to that Student's existing data and Sessions.
- Username matching is case-sensitive.
- Usernames may contain printable Unicode characters, including symbols, diacritics, and non-Latin characters.
- Usernames may not contain whitespace, control characters, or invisible formatting characters.
- Usernames are normalized using Unicode NFC before storage and comparison.
- After NFC normalization, usernames are compared exactly.
- No password is required. #FutureRelease
- During log in, if the Username does not exist, an error is shown.
- During account creation, if the Username already exists, an error is shown.

## Subjects, Categories, Questions, and Answers

- Every Subject has zero or more Categories.
- Every Category belongs to only one Subject.
- Every Question belongs to only one Subject.
- If a Subject has Categories, a Question from the Subject may belong to one Category or remain uncategorized.
- If a Subject has no Categories, all Questions from the Subject will be uncategorized.
- Every Question has exactly one Primary Answer and may have one Alternate Answer.
- A Guess is correct when it matches either Answer according to the Guess Evaluation rules.
- Only the Primary Answer is displayed to Students.
- Subjects and Categories are global/shared. There is no such thing as private Subject/Questions for a specific Student.
- Creating or editing Subjects, Questions, Answers, etc. will not be available to Students. #FutureRelease
- In the initial release, only the Administrator can create, edit, or delete Subjects, Categories, Questions, and Answers. Administrative functionality is not available through the Student interface.

- Example 1:
  - Subject: `World Capitals`
  - Category: `Europe`
  - Question: `United Kingdom`
  - Primary Answer: `London`
- Example 2:
  - Subject: `French`
  - Category: none
  - Question: `Lunch`
  - Primary Answer: `Déjeuner`

## Sessions

- A Session is a subset of Questions from one Subject.
- A Student may have multiple active Sessions, including multiple Sessions for the same Subject.
- A Student is limited to five active Sessions.
- A Session ends when every Question in the Session has been answered correctly.
- Once a Question is answered correctly, it is not asked again during that Session.
- The set of Questions in a Session is determined when the Session starts and does not change afterward.
- Assume that the Subject, Category, Question, Primary Answer, and Alternate Answer will not be edited or deleted while the Session is in progress, so any such interaction can be ignored.
  - Note that this assumption requires an operational promise from administrators, which has been deemed ok for the first release.

## Landing Page

- After a Student logs in with their Username, the Student is presented with:
  - The Recollect It wordmark in the upper left.
  - A Log Out button in the upper right.
    - Logging out ends the Student's current browser identity and returns the Student to the Log In page.
    - Logging out does not abandon active Sessions or otherwise change the Student's saved data.
  - The Student's Username.
  - A highlighted section with a single button to create a new Session.
  - A section that lists all active Sessions, along with a "Resume" button and "Abandon" button next to each active Session.
    - For each active Session, show the Subject, Categories (if applicable), and creation date.
    - If there are no active Sessions, this section will simply show a note saying "No active sessions.".
    - The "Resume" button will navigate to /sessions/{session_id}
    - The "Abandon" button should prompt the Student to confirm that they want to Abandon the Session before the Session is actually abandoned.
    - Abandoning a Session marks the Session as completed. The Session is retained in history along with its accumulated Attempt counts and their effect on Question Accuracy. Individual Guesses are not retained.    
  - A section that lists historical Sessions, in order of most recently completed first.
    - For each historical Session, show the Subject, Categories (if applicable), completion date, and Session Accuracy.
    - If a historical Session was abandoned, show an "Abandoned" label instead of Session Accuracy.
    - The historical Session is click-able, and when clicked, direct them to the Session Complete page.
    - If there are no historical Sessions, this section will simply show a note saying "No completed sessions.".

## Session Creation

- When creating a new Session, the Student will be shown a page with the following content:
  - A Recollect It watermark/logo in the upper left which takes the Student back to the Landing Page.
  - Near the top, explanatory text stating that a Session continues until every Question is answered correctly, with later Rounds containing only Questions missed in the previous Round.
  - A dropdown menu to select a Subject.
  - A checkbox with **Ask All Questions**.
  - A multi-select List Box to select a Category if the Subject has one or more Categories, otherwise the Category list box is not visible.
  - A Question Accuracy filter displayed as **Question Accuracy: X Y**, where X is a dropdown menu to select `<=` or `>=` and Y is a dropdown menu to select a percentage from 0% to 100% in increments of 10%.
    - If the Student has never Attempted any Question from the selected Subject, the Question Accuracy filter is hidden and Question Accuracy does not restrict the eligible Questions.
    - Implementation details can be altered as long as the spirit of the feature is maintained.
    - Example: If Question Accuracy <= 40% is selected, only Questions with an Accuracy of 40% or less are included.
  - Between the Session options and the page buttons, show the total number of Questions to be asked based on the selected options.
    - Show the neutral guidance **For a manageable study session, aim for 15–35 questions.** in smaller text.
  - A button called **Home** that takes the Student to the Landing Page.
  - A button called **Start Session**.
  - Filter changes should call the API endpoint immediately.
- **Start Session** calls `POST /api/sessions` with the selected Subject and filters. The endpoint returns only the new `sessionId`, after which the browser navigates to `/sessions/{sessionId}`.
- While the start request is in progress, **Start Session** is disabled to prevent accidental duplicate Sessions. If the request fails, the Student remains on the page, sees an error, and may retry.
- If **Ask All Questions** is checked, all other filters on the page should disappear.
- **Ask All Questions** will default to unchecked
- Subjects to be displayed in alphabetical order.
- Categories to be displayed in alphabetical order.
- The Subject will default to the Subject from the Student's last completed Session (including abandoned Sessions); if the Student has no completed Sessions, the first Subject in display order is selected by default.
- No Categories are selected by default.
- The Category list box user experience should be designed so it is easy to de-select a Category, including de-selecting a Category so there are zero selected.
- X will default to `<=`.
- Y will default to `100%`.
- If one or more Categories are selected, only Questions matching the selected Categories will be included in the Session.
- If no Categories are selected, all Questions in the selected Subject are eligible, including uncategorized Questions.
- The Student cannot filter specifically for uncategorized Questions.
- Question Accuracy is `Correct Attempts / Total Attempts` and includes every submitted Guess from all active and completed Sessions for that Student.
- If a Student has never Attempted the Question before, that Question's Accuracy = 0%.
- Note that `Question Accuracy >= 0%` and `Question Accuracy <= 100%` are logically equivalent to asking all Questions.
- Category and Accuracy filters may be used together, and when they are used together, the filters use AND logic, e.g. `Category IN (North America, South America) AND Accuracy <= 50%`.
- A Session cannot be started if the selected options produce zero eligible Questions; an explanatory error is shown.

## Session

- The Session page will have the following content:
  - A section showing info about the Session:
    - The Subject
    - The Categories, if applicable
      - Categories are the distinct categorized Questions represented in the Session's fixed Question set. Uncategorized Questions do not add a Category label.
  - The Round number on its own line or in its own section, e.g. `Round 1`.
    - When the Round advances, a banner containing `Round X` is centered over the Q&A pane, and the pane is visually subdued for the duration of the transition. The Guess input remains enabled so the Student may begin entering the next answer, while **Skip for now** and **Submit** remain unavailable.
    - The transition from Round 1 to Round 2 lasts 2 seconds. Every later Round transition lasts 1.2 seconds.
    - When the banner is removed, focus returns to the Guess input. The Round change is announced politely to assistive technology.
  - Session progress on a separate line or in a separate section, e.g. `5 of 20 answered correctly`.
    - The first number is the number of Questions in the Session that have been answered correctly.
    - The second number is the total number of Questions in the Session.
  - A section for the Q&A:
    - The Question
    - The Student's Question Accuracy, rounded to the nearest whole percentage, when the Student has answered the Question correctly at least once across any Session.
      - Display Question Accuracy in the Question card header near the Question label.
      - Calculate the percentage from all Correct Attempts and Total Attempts for that Question by that Student across all active and completed Sessions, including the current Session.
      - If the Student has never answered the Question correctly, do not display Question Accuracy.
    - An area to display the Guess as it is typed
    - A **Skip for now** button
    - A **Submit** button
  - A section showing the previous Q&A:
    - The previous Question
    - The Primary Answer
    - The most recently submitted Guess
    - Whether the Guess was correct or incorrect
    - Show three panes in this order: **Question**, **Correct Answer**, and **Your Guess**.
    - The section is a top-level pane displayed between the Session summary and the current Q&A pane.

- Pressing Enter functions the same as clicking **Submit** when the Guess input has focus.
- An empty Guess is valid.
- The Guess is limited to 100 characters.
- The Guess form and input will provide advisory hints requesting that browsers, virtual keyboards, and common password managers disable autofill, autocorrection, spellcheck, and credential or personal-information suggestions. The browser and keyboard retain final control and may ignore these hints.
- Only the **Your Guess** pane will use a light green or red background with a stronger status-colored border. Guess text remains dark, and an explicit correct or incorrect icon is displayed immediately before the Guess. The words **Correct** and **Incorrect** are not displayed visually, but the outcome remains available to assistive technology so it does not rely on color or the icon alone. The **Question** and **Correct Answer** panes remain visually neutral.
- The previous Q&A section is hidden until the Student submits a Guess after opening or resuming the Session page.
- **Skip for now** does not count as a Guess/Attempt and does not affect the previous Q&A section.
- A skipped Question remains pending in the current Round, and a different pending Question is selected randomly. The skipped Question must be presented and Attempted later before the Round can end.
- If the current Question is the only pending Question to be asked in the Round, the **Skip for now** button will show an error message.
- For errors returned by the server, show a short message and attempt to reload the state and display a valid Question.
- A Session ends immediately after the Student correctly answers the last incomplete Question. At the end of the Session, immediately redirect the Student to the Session Complete page.

## Question Ordering and Rounds

- Questions will be asked at random.
- Round 1 requires one Attempt for every Question in the Session before any Question receives a second Attempt.
- Round 2 requires one Attempt for every Question still incomplete before any incomplete Question receives another Attempt.
- The same rule applies to subsequent Rounds.
- A Question answered correctly is excluded from all later Rounds in that Session.
- After a Guess, the same Question must not be asked twice in a row unless it is the only incomplete Question remaining in the Session.

## Guess Evaluation

Normalize the Student's Guess and each of the Question's available Answers before comparison. Normalization must:

1. Replace ø, ł, ß, æ, and œ with o, l, ss, ae, and oe, including their uppercase equivalents.
2. Convert all letters to lowercase using Unicode case conversion.
3. Remove diacritics, whitespace, punctuation, and symbols.

Examples:
- `São Paulo` -> `saopaulo`
- `WASHINGTON, D.C.` -> `washingtondc`
- `New-York` -> `newyork`
- `C’est combien?` -> `cestcombien`

After normalization, compare the Guess independently with the Primary Answer and, when present, the Alternate Answer. Use Damerau-Levenshtein distance to determine whether each comparison is close enough to be considered correct. The Attempt is correct when either Answer matches.
  - Use a distance of 0 for 1–4 characters, distance of 1 for 5–8 characters, distance of 2 for 9 or more characters.
  - The number of characters is defined by the particular Answer being compared, not the Guess. The Primary and Alternate Answers may therefore use different distance thresholds.
  - A Guess whose normalized value is empty is valid and will be automatically marked as incorrect.

## Accuracy

For each Student: `Question Accuracy = Correct Attempts / Total Attempts`

- Every submitted Guess counts as one Attempt.
- Correct and incorrect Attempts update the Question's historical Accuracy.
- Attempts in any Session affect future Session filtering for that Student.
- Changes to Question Accuracy do not alter the Questions to be asked of Sessions that have already started.

For one Student and Question:

- Total Attempts = the sum of session_questions.attempts.
- Correct Attempts = the number of those rows whose completed_at is not NULL.
- Question Accuracy = Correct Attempts / Total Attempts.
- If Total Attempts is zero, Accuracy is 0%.

## Session Complete

The Session end screen will display:
- Confirmation that the Session has ended.
- If the Session was abandoned, note that it was abandoned. Abandonment is true if any Question from the Session remains incomplete.
- Show the Session's Subject, Categories (if applicable), and completion date.
- Show the Session Accuracy, rounded to the nearest integer, where `Session Accuracy = Unique Questions / Total Attempts * 100`. Also show the number of unique Questions in the Session and the Total Attempts submitted. If the Session was abandoned, do not show Session Accuracy.
- Show a table with the following columns: Question, Answer, Attempts, Question Accuracy. The Answer column displays only the Primary Answer. Attempts is the number of Attempts submitted for that Question in this Session. For this table, Question Accuracy is calculated only from the completed Session: `Correct Attempts for the Question in this Session / Attempts for the Question in this Session`. It does not include Attempts from any other Session. The table is sorted by this session-only Question Accuracy ascending. If the Session was abandoned, do not show this table.
- If the page is loaded but the Session is not complete, show an error indicating that the Session is still in progress. Do not show any other info that would normally be shown for a completed Session.
- Since this is a static page with no interaction, except clicking the wordmark to go back to the Landing page, if errors occur, display an error, log the error in the logs table, but do not try to reload or attempt to correct the problem.
- The page should be retrieved via a Server Component, not an API

## Mobile Requirements

- The application must work well on common mobile, tablet, and desktop screen sizes.
- The application will use one responsive layout that adapts to the available viewport width rather than detecting a specific device type.
- The Question and Guess input should remain easy to read and use on a phone.
- Controls must be touch-friendly.
- Core study interactions must not depend on hover.
- On narrow screens, the Session Subject, Categories, Round, and progress will be presented as one compact summary, while wider screens may use the more spacious card layout.
- On narrow screens, the visible **Your answer** label will be hidden while remaining available to assistive technology. When the empty Guess input is not focused, it will show **Type answer here** in light gray; the hint disappears when the input receives focus.
- On narrow screens, the previous Q&A will use a compact single-column presentation in the same **Question**, **Correct Answer**, **Your Guess** order, decorative spacing will be reduced, and **Skip for now** and **Submit** will remain side by side while retaining touch-friendly sizes.
- Responsive changes must not reduce the readability or usability of the wider-screen Session layout.
