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
- **Response**: the Student's submitted answer to a Question.
- **Attempt**: one Question presentation followed by a submitted Response.
- **Subject**: a topic containing Questions, e.g. `World Capitals`.
- **Category**: Sub-topics within a Subject, e.g. `Europe`.
- **Session**: a fixed set of Questions from one Subject that continues until every Question has been answered correctly.
- **Success Rate**: for a Student and Question, `Correct Attempts / Total Attempts`.
- **Round**: one pass through every Question that remains incomplete in a Session.
- **#FutureRelease**: indicates that a requirement may change in a future release; this is for notation only and does not affect the current requirements.

## Student Access

- A Student accesses the application using only a Username.
- Entering the same Username must provide access to that Student's existing data and Sessions.
- Username matching is case-sensitive.
- Usernames may contain printable Unicode characters, including symbols, diacritics, and non-Latin characters.
- Usernames may not contain whitespace, control characters, or invisible formatting characters.
- Usernames are normalized using Unicode NFC before storage and comparison.
- After NFC normalization, usernames are compared exactly.
- No password is required. #FutureRelease
- During account creation, if the Username is already chosen, the new Student will receive an error and must choose another Username.

## Subjects, Categories, Questions, and Answers

- Every Subject has zero or more Categories.
- Every Category belongs to only one Subject.
- Every Question belongs to only one Subject and to only one Category if the Subject has Categories.
- Every Question has only one Answer. #FutureRelease
- Subjects and Categories are global/shared, there is no such thing as private Subject/Questions for a specific Student.
- Creating or editing Subjects, Questions, Answers, etc. will not be available to Students. #FutureRelease

- Example1:
  - Subject: `World Capitals`
  - Category: `Europe`
  - Question: `United Kingdom`
  - Answer: `London`
- Example2:
  - Subject: `French`
  - Category: none
  - Question: `Lunch`
  - Answer: `Déjeuner`

## Sessions

- A Session is a subset of Questions from one Subject.
- A Student may have multiple active Sessions, including multiple Sessions for the same Subject.
- A Student is limited to 5 active Sessions.
- A Session ends when every Question in the Session has been answered correctly.
- Once a Question is answered correctly, it is not asked again during that Session.
- The set of Questions in a Session is determined when the Session starts and does not change afterward.
- A Subject, Category, Question, and Answer will not be edited or deleted while the Session is in progress, so any such interaction can be ignored.
- An active Session may be abandoned.
- A completed Session is retained as history.

## Landing Page

- After a Student logs in with their Username, the Student is presented with:
  - A section that lists any and all active Sessions, along with a "Resume" button next to each active Session.
  - A highlighted section with a single button to create a new Session.
  - A section that lists historical Sessions.

## Session Creation

- When creating a new Session, the Student will be shown a page with the following content:
  - A button in the upper left called **Landing Page** which takes the Student back to the Landing Page
  - The total number of Questions to be asked in the Session based on the options selected within the page.
  - Dropdown menu to select a Subject.
  - Checkbox with **Ask All Questions**
  - Multi-select List Box to select a Category if the Subject has 1 or more Categories, otherwise the Category list box is not visible
  - A filter to **Ask Only Questions That Have Been Answered Correctly: X Y**, where X is a dropdown menu to select `<=` or `>=` and Y is a dropdown menu to select a percentage from 0% to 100% in increments of 10%.
  - A button called **Start Session**

- If **Ask All Questions** is checked, all other filters on the page should disappear.
- **Ask All Questions** will default to unchecked.
- The Subject will default to the Subject with id = 1.
- The Category will default to none selected.
- The Category list box user experience should be designed so it is easy to de-select a Category, including de-selecting a Category so there are zero selected.
- X will default to `<=`
- Y will default to `60%`
- If one or more Categories are selected, only Questions matching the selected Categories will be included in the Session.
- Success Rate for a Question is the `Correct Attempts / Total Attempts` for that Question and for that Student across all historical Sessions.
- If a Student has never Attempted the Question before, that Question's Success Rate = 0%.
- Example: Success Rate <= 49% is selected as the filter, then only those Questions with a Success Rate <= 49% will be included in the Session.
- Note that `Success Rate >= 0%` and `Success Rate <= 100%` are logically equivalent to asking all Questions.
- Category and Success Rate filters may be used together, and when they are used together, the filters use AND logic, e.g. `Category IN (North America, South America) AND Success Rate <= 50%`.
- If the total number of Questions to be asked is zero, the **Start Session** button will produce an error

## Session

- The Session page will have the following content:
  - A section showing the filters used:
    - The Subject
    - The Categories, if applicable
    - The Success Rate with the greater than or less than sign and percentage, if applicable
  - The Round number along with the question number out of the total questions for the current round, e.g. `Round 1 : Question 5/20`
  - A section for the Q&A:
    - The Question
	- An area to display the Response as it is typed
	- A **Skip for now** button
	- A **Submit** button
  - A section showing the previous Q&A:
	- The previous Question
	- The previous Question's Answer
	- The Student's Response to the previous Question

- Pressing Enter functions the same as clicking **Submit**
- The Student's Response to the previous Question will be highlighted in such a way as to make it obvious as to whether it was correct or not, e.g. being colored green or red.
- If it is the first question of the browser's web session for this Session, the previous Q&A section will not be shown.

## Question Ordering and Rounds

- Questions will be asked at random.
- Round 1 asks every Question in the Session once before any Question is asked a second time.
- Round 2 asks every Question still incomplete once before any incomplete Question is asked a third time.
- The same rule applies to subsequent Rounds.
- A Question answered correctly is excluded from all later Rounds in that Session.
- A Question must not be asked twice in a row unless it is the only incomplete Question remaining in the Session.

## Response Evaluation

Normalize both the Student Response and Question's Answer before comparison.

Normalization must:

1. Ignore case.
2. Remove diacritics.
3. Remove whitespace.
4. Remove symbols and special characters.

Examples:

- `São Paulo` -> `saopaulo`
- `WASHINGTON, D.C.` -> `washingtondc`
- `New-York` -> `newyork`

After normalization:

1. If the normalized Response exactly matches an accepted answer, it is correct.
2. Otherwise, use Damerau-Levenshtein distance to determine whether the Response is close enough to be considered correct: distance of 0 for 1–4 characters, distance of 1 for 5–7 characters, distance of 2 for 8-13 characters, distance of 3 for 14+ characters.

## Success Rate

For each Student and Question:

`Success Rate = Correct Attempts / Total Attempts`

- Every submitted Response counts as one Attempt.
- Correct and incorrect Attempts update the Question's historical Success Rate.
- Attempts in any Session affect future Session filtering for that Student.
- Changes to Success Rate do not alter the Questions to be asked of Sessions that have already started.

## Session Completion

A Session ends immediately after the Student correctly answers the last incomplete Question.

Display:

- Confirmation that the Session has ended.
- Number of unique Questions in the Session.
- Number of total Questions asked.
- Overall percentage correct, rounded to the nearest integer.

`Overall Percentage Correct = Unique Questions / Total Questions Asked * 100`
`Total Questions Asked` means the total number of Attempts made during the Session.

Example:

- Unique Questions: `20`
- Total Questions Asked: `25`
- Overall Percentage Correct: `80%`

## Mobile Requirements

- The application must work well on common mobile, tablet, and desktop screen sizes.
- The Question and Response input should remain easy to read and use on a phone.
- Controls must be touch-friendly.
- Core study interactions must not depend on hover.

## Initial Release

The implementation should be developed incrementally even though the complete intended product behavior is documented here.
