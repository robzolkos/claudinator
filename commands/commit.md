---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(rubocop:*)
description: Create a git commit with automated linting and context-aware subject
model: claude-3-5-haiku-20241022
---

## Context

### Current State

- Working directory status: !`git status --porcelain`
- Current branch: !`git branch --show-current`
- Staged changes: !`git diff --staged --stat`
- Unstaged changes: !`git diff --stat`

### Detailed Changes

- Full diff (staged and unstaged): !`git diff HEAD`
- Staged changes detail: !`git diff --staged`

### Repository History

- Recent commits with graph: !`git log --oneline -10 --graph`
- Commits on current branch (not on main): !`git log --oneline main..HEAD 2>/dev/null || echo "Not branched from main"`

## Your Task

### Pre-commit Checks

1. **Verify there are changes to commit**
   - If no changes exist, inform the user and stop
   - If only unstaged changes exist, suggest which files should be staged

2. **Ruby File Linting**
   - Check if any Ruby files (*.rb,*.rake, Gemfile, *.gemspec) are modified in the diff
   - If Ruby files are found, run `rubocop -a` to auto-correct any style violations
   - If rubocop makes changes, add them to the commit
   - Report any remaining rubocop offenses that couldn't be auto-corrected

3. **Branch Verification**
   - Confirm the user is on the intended branch
   - Warn if committing directly to main/master

### Creating the Commit

Based on the changes, create a single git commit following these guidelines:

**Commit Message Format:**

Subject line:

- 50 characters or less
- Start with a capital letter
- Do not end with a period
- Use imperative mood ("Add" not "Added")
- Write a succinct subject about the change.

Do not include a Body.

### Final Steps

1. Stage all intended changes
2. Create the commit with a well-crafted subject.  Do not include a body.
3. Show the commit confirmation with `git log -1 --stat`
