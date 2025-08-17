---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(rubocop:*), Bash(gh:*)
description: Create a pull request with automated linting, branch verification, and succinct description
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

### Pre-PR Checks

1. **Branch Verification**
   - Confirm the user is NOT on main/master branch
   - If on main/master, inform the user they need to create a feature branch first

2. **Ruby File Linting**
   - Check if any Ruby files (*.rb,*.rake, Gemfile, *.gemspec) are modified in the diff
   - If Ruby files are found, run `rubocop -a` to auto-correct any style violations
   - If rubocop makes changes, add them to the commit
   - Report any remaining rubocop offenses that couldn't be auto-corrected

3. **Verify there are changes to commit**
   - If no changes exist, inform the user and stop
   - If only unstaged changes exist, stage appropriate files

### Creating the Pull Request

Based on the changes, create a pull request with:

**PR Title:**

- 50 characters or less
- Start with a capital letter
- Use imperative mood ("Add" not "Added")
- Succinct summary of the change

**PR Description:**

- Brief bullet points of what changed
- Focus on the "why" rather than the "what"
- Keep it concise (2-4 bullets max)

### Final Steps

1. Stage all intended changes
2. Create a commit if there are uncommitted changes
3. Push the branch to remote
4. Create the pull request using `gh pr create`
5. Display the PR URL for the user
