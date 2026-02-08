---
name: git-quick-push
description: Quickly complete git add, commit, and push workflow. Use when user wants to commit code, push changes, or says things like "commit this", "push the code", "ship it", etc.
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*)
---

## Context

- Current git status: !`git status`
- Current changes (staged + unstaged): !`git diff HEAD`
- Current branch: !`git branch --show-current`

## Task

Based on the above changes, execute on the current branch:

1. `git add .` to stage all changes
2. `git commit -m "<message>"` with an auto-generated message based on the diff
3. `git push` to push to remote

Requirements:
- Complete all operations in a single message
- Commit message should be concise and describe the core changes
- If push fails (e.g., remote has new commits), prompt user to pull first
