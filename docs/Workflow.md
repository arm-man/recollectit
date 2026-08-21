# Development Workflow

## Have AI Create The Prompt

- Obtain as many specifics about the change as you can and include them in the prompt.
  - e.g. don't say `show an error` but instead say `display the error: The maximum length of the username is 25 characters`.
- Follow the Template below and add the final prompt to GitHub Issues for record keeping.

## Template

Please create an AI prompt that I can provide to Codex to implement the change: <summarize the change in one sentence>.
To create the best prompt, ask me relevant questions. Do not create the prompt until you receive answers from me to all of your questions.

In the prompt, create the Section: `Before making changes`, which, at a minimum, will include:
- Read and follow AIInstructions.md.
- Update any .md files in docs\ as appropriate, e.g. you are explicitly told to add or change a feature/requirement.
- The repository's AIInstructions.md, which in turn references API.md, Architecture.md, CodingStandards.md, Database.md, and Product.md, are the authoritative source for existing project architecture, coding standards, conventions, and general development instructions. Do not repeat or restate instructions that can be obtained by reading those files. Instead, ensure the prompt that you create includes instruction to read the relevant documentation and rely on it.
- If you want to add emphasis in the prompt on a specific requirement, add something like: "Pay particular attention to docs/CodingStandards.md when implementing X" rather than copying its rules into the prompt.
- Inspect the existing application structure, styles, and package.json before deciding which files to modify.

In the prompt, create the Section: `Requirements`, which, at a minimum, will include:
- Create files based on the project's documented folder structure and conventions.
- Keep the implementation simple.

In the prompt, create a Section: `After making the change`, which, at a minimum, will include:
- Explain each important decision made and important part of the implementation.

## After Prompt Creation

Add this to the AI-generated prompt before giving it to Codex: "If an important requirement remains ambiguous after reviewing the project documentation and existing implementation, ask me before making that decision. Otherwise, proceed without asking unnecessary questions."

## After AI Code Changes

1. Review the AI summary and changes made by the AI.
   - Use `git diff` to check for unrelated or unexpected changes.
   - Pay special attention to dependency, database, configuration, and migration changes.
2. Ensure relevant tests pass.
   - `npm test`
3. Run the application locally and manually test the changed behavior.
   - `npm run dev`
   - http://localhost:3000
4. Run automated validation.
   - `npm run validate` (see package.json. performs format check, type check, and lint. I need to install the commands.)
4. Commit and push the changes.
   - Include `Resolves #X.` at the end of the commit message so that GitHub automatically closes Issue #X.
5. Verify the Vercel deployment.
   - https://recollectit.vercel.app/
   - If Vercel fails to build, I should be able to duplicate the error with: `npm run build`

## Periodically

- Have Codex review and improve the .md docs
- Have Codex review and clean up the code, e.g. remove obsolete code.
