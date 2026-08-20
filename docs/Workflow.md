# Development Workflow

## After AI Code Changes

1. Review the AI summary and changes made by the AI.
   - Use `git diff` to check for unrelated or unexpected changes.
   - Pay special attention to dependency, database, configuration, and migration changes.
2. Ensure relevant tests pass.
   - `npm test`
3. Run the application locally and manually test the changed behavior.
   - `npm run dev`
4. Run automated validation.
   - `npm run validate` (see package.json. performs format check, type check, and lint. I need to install the commands.)
4. Commit and push the changes.
5. Verify the Vercel deployment.
   - If Vercel fails to build, I should be able to duplicate the error with: `npm run build`
