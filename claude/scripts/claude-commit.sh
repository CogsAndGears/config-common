#!/usr/bin/env bash
git diff --staged | claude -p "Write a git commit message for these staged changes. Use a short subject line, and if the changes warrant it, add a blank line followed by a more detailed body. Output only the raw commit message text — no explanation, no quotes."

