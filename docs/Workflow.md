# Development Workflow

## Have AI Create The Prompt

- Obtain as many specifics about the change as you can and include them in the prompt.
  - e.g. don't say `show an error` but instead say `display the error: The maximum length of the username is 25 characters`.
- Follow the Template below and add the final prompt to GitHub Issues for record keeping.

## Template

Please create an AI prompt that I can provide to Codex to implement the change: <summarize the change in one sentence>.
To create the best prompt, ask me relevant questions. Do not create the prompt until you receive answers from me to all the questions.
In the created prompt, include the Section: `Before making changes`, which, at a minimum, will include:
- Read and follow AIInstructions.md.
- Update any .md files in docs\ as appropriate.
- Inspect the existing application structure, styles, and package.json before deciding which files to modify.
In the created prompt, include the Section: `Requirements`, which, at a minimum, will include:
- Create files (e.g. db.ts) based on the project's documented folder structure and conventions.
- Keep the implementation simple. Do not introduce an ORM, query builder, database abstraction framework, or unnecessary wrapper classes.
- Add brief comments only where they explain something non-obvious.
- Follow the TypeScript and naming conventions in CodingStandards.md.
- Do not modify unrelated files.
In the created prompt, include a Section: `After making the change`, which, at a minimum, will include:
- Explain each important part of the implementation.
- Run the appropriate TypeScript/lint checks that already exist in the project.
- Do not commit the change to Git.

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
5. Verify the Vercel deployment.
   - https://recollectit.vercel.app/
   - If Vercel fails to build, I should be able to duplicate the error with: `npm run build`
