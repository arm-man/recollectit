# Recollect It Product Specification

## Overview

Recollect It is a mobile-friendly, web-based flashcard application for anyone who wants to memorize or review information.

Primary user goal: review existing knowledge.

Primary product success measure: students study regularly.

## Terminology

- **Student**: the person using Recollect It.
- **Username**: the name used to access a student's data.
- **Question**: a prompt presented to the Student.
- **Answer**: the correct answer to the Question.
- **Guess**: the Student's submitted answer to a Question.
- **Attempt**: the submission of one Guess for a Question. While similar to Guess, an Attempt includes the Guess along with other potential info such as timestamp, whether the Guess was correct, etc.
- **Subject**: a topic containing Questions, e.g. `World Capitals`.
- **Category**: A subtopic within a Subject, e.g. `Europe`.
- **Session**: a fixed set of Questions from one Subject that continues until every Question has been answered correctly.
- **Question Accuracy**: for a Student, `Correct Attempts / Total Attempts`.
- **Round**: a period during which every Question that was incomplete when the Round began must receive one Attempt.
- **#FutureRelease**: indicates that a requirement may change in a future release; this is for notation only and does not affect the current requirements.

## Student Access

- The initial page is the Log In page, which has two sections, one to log in and another to create a Username.
- A Student accesses the application using only a Username.
- Entering the same Username provides access to that Student's existing data and Sessions.
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
- Every Question has only one Answer. #FutureRelease
- Subjects and Categories are global/shared. There is no such thing as private Subject/Questions for a specific Student.
- Creating or editing Subjects, Questions, Answers, etc. will not be available to Students. #FutureRelease
- In the initial release, only the Administrator can create, edit, or delete Subjects, Categories, Questions, and Answers. Administrative functionality is not available through the Student interface.

- Example 1:
  - Subject: `World Capitals`
  - Category: `Europe`
  - Question: `United Kingdom`
  - Answer: `London`
- Example 2:
  - Subject: `French`
  - Category: none
  - Question: `Lunch`
  - Answer: `Déjeuner`

## Sessions

- A Session is a subset of Questions from one Subject.
- A Student may have multiple active Sessions, including multiple Sessions for the same Subject.
- A Student is limited to five active Sessions.
- A Session ends when every Question in the Session has been answered correctly.
- Once a Question is answered correctly, it is not asked again during that Session.
- The set of Questions in a Session is determined when the Session starts and does not change afterward.
- Assume that the Subject, Category, Question, and Answer will not be edited or deleted while the Session is in progress, so any such interaction can be ignored.
  - Note that this assumption requires an operational promise from administrators, which has been deemed ok for the first release.
- An active Session may be abandoned. Any time the Student attempts to Abandon a Session, a confirmation prompt is shown to the Student before the Session is actually abandoned.
- Abandoning a Session deletes the Session and it will not be retained as history, but abandonment does not delete its Attempts or reverse their effect on Question Accuracy.

## Landing Page

- After a Student logs in with their Username, the Student is presented with:
  - A section that lists all active Sessions, along with a "Resume" button and "Abandon" button next to each active Session.
    - For each active Session, show the Subject and creation date.
	- If there are no active Sessions, this section will not be shown.
  - A highlighted section with a single button to create a new Session.
  - A section that lists historical Sessions, in order of most recently completed first.
    - If there are no historical Sessions, this section will not be shown.

## Session Creation

- When creating a new Session, the Student will be shown a page with the following content:
  - A button in the upper left called **Landing Page** which takes the Student back to the Landing Page.
  - The total number of Questions to be asked in the Session based on the options selected within the page.
  - A dropdown menu to select a Subject.
  - A checkbox with **Ask All Questions**.
  - A multi-select List Box to select a Category if the Subject has one or more Categories, otherwise the Category list box is not visible.
  - A Question Accuracy filter displayed as **Question Accuracy: X Y**, where X is a dropdown menu to select `<=` or `>=` and Y is a dropdown menu to select a percentage from 0% to 100% in increments of 10%.
    - Implementation details can be altered as long as the spirit of the feature is maintained.
    - Example: If Question Accuracy <= 40% is selected, only Questions with an Accuracy of 40% or less are included.
  - A button called **Start Session**.

- If **Ask All Questions** is checked, all other filters on the page should disappear.
- **Ask All Questions** will default to unchecked.
- Subjects to be displayed in alphabetical order.
- Categories to be displayed in alphabetical order.
- The Subject will default to the Subject from the Student's last completed Session; if the Student has no completed Sessions, the first Subject in display order is selected by default.
- No Categories are selected by default.
- The Category list box user experience should be designed so it is easy to de-select a Category, including de-selecting a Category so there are zero selected.
- X will default to `<=`.
- Y will default to `60%`.
- If one or more Categories are selected, only Questions matching the selected Categories will be included in the Session.
- If no Categories are selected, all Questions in the selected Subject are eligible, including uncategorized Questions.
- The Student cannot filter specifically for uncategorized Questions.
- Question Accuracy is `Correct Attempts / Total Attempts` and includes every submitted Guess from all active, completed, and subsequently abandoned Sessions for that Student.
- If a Student has never Attempted the Question before, that Question's Accuracy = 0%.
- Note that `Question Accuracy >= 0%` and `Question Accuracy <= 100%` are logically equivalent to asking all Questions.
- Category and Accuracy filters may be used together, and when they are used together, the filters use AND logic, e.g. `Category IN (North America, South America) AND Accuracy <= 50%`.
- A Session cannot be started if the selected options produce zero eligible Questions; an explanatory error is shown.

## Session

- The Session page will have the following content:
  - A section showing the filters used:
    - The Subject
    - The Categories, if applicable
    - The Question Accuracy with the greater than or less than sign and percentage, if applicable
  - The Round number along with the question number out of the total questions for the current round, e.g. `Round 1 : Question 5 of 20`
	- The numerator (i.e. the 5 in the label `Question 5 of 20`) represents the number of Questions Attempted in the current Round plus one. Skipping does not advance it. Therefore, the replacement Question displays the same numerator as the skipped Question.
    - The denominator (i.e. the 20 in the label `Question 5 of 20`) is the Round question count which is fixed when the Round begins. In this example, there will be 20 Attempts scheduled for the Round.
  - A section for the Q&A:
    - The Question
	- An area to display the Guess as it is typed
	- A **Skip for now** button
	- A **Submit** button
  - A section showing the previous Q&A:
	- The previous Question
	- The previous Answer
	- The previous Guess

- Pressing Enter functions the same as clicking **Submit** when the Guess input has focus.
- An empty Guess is valid.
- The Student's Guess to the previous Question will be highlighted in such a way as to make it obvious as to whether it was correct or not, e.g. being colored green or red.
- The previous Q&A section is hidden until the Student submits a Guess after opening or resuming the Session page.
- **Skip for now** does not count as a Guess/Attempt and does not affect the previous Q&A section.
- A skipped Question remains pending in the current Round, and a different pending Question is selected randomly. The skipped Question must be presented and Attempted later before the Round can end.
- If the current Question is the only pending Question to be asked in the Round, the **Skip for now** button will show an error message.

## Question Ordering and Rounds

- Questions will be asked at random.
- Round 1 requires one Attempt for every Question in the Session before any Question receives a second Attempt.
- Round 2 requires one Attempt for every Question still incomplete before any incomplete Question receives another Attempt.
- The same rule applies to subsequent Rounds.
- A Question answered correctly is excluded from all later Rounds in that Session.
- A Question must not be asked twice in a row unless it is the only incomplete Question remaining in the Session.

## Guess Evaluation

Normalize both the Student's Guess and Question's Answer before comparison. Normalization must:

1. Replace ø, ł, ß, æ, and œ with o, l, ss, ae, and oe, including their uppercase equivalents.
2. Convert all letters to lowercase using Unicode case conversion.
3. Remove diacritics, whitespace, punctuation, and symbols.

Examples:
- `São Paulo` -> `saopaulo`
- `WASHINGTON, D.C.` -> `washingtondc`
- `New-York` -> `newyork`
- `C’est combien?` -> `cestcombien`

After normalization, use Damerau-Levenshtein distance to determine whether the Guess is close enough to be considered correct.
  - Use a distance of 0 for 1–4 characters, distance of 1 for 5–8 characters, distance of 2 for 9 or more characters.
  - The number of characters is defined by the Answer, not the Guess.
  - A Guess whose normalized value is empty is valid and will be automatically marked as incorrect.

## Accuracy

For each Student: `Question Accuracy = Correct Attempts / Total Attempts`

- Every submitted Guess counts as one Attempt.
- Correct and incorrect Attempts update the Question's historical Accuracy.
- Attempts in any Session affect future Session filtering for that Student.
- Changes to Question Accuracy do not alter the Questions to be asked of Sessions that have already started.

## Session Completion

A Session ends immediately after the Student correctly answers the last incomplete Question. The Session end screen will display:
- Confirmation that the Session has ended.
- Number of unique Questions in the Session.
- Number of Guesses submitted, where skipped questions do not count as Guesses.
- Session Accuracy, rounded to the nearest integer, where `Session Accuracy = Unique Questions / Guesses * 100`

Example:
- Unique Questions: `20`
- Total Guesses: `25`
- Session Accuracy: `80%`

## Mobile Requirements

- The application must work well on common mobile, tablet, and desktop screen sizes.
- The Question and Guess input should remain easy to read and use on a phone.
- Controls must be touch-friendly.
- Core study interactions must not depend on hover.

## Initial Release

The implementation should be developed incrementally even though the complete intended product behavior is documented here.
