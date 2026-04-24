---
name: review-pr
description: Reviews the code in the branch. Makes sure syntax conventions are followed and code structure and flow make logical sense.
allowed-tools: Bash(gh *)
---

## Pull request context
- PR diff: !`gh pr diff`
- Changed files: !`gh pr diff --name-only`

When reviewing code, always include:

1. **Summarize the code**: state what the code does in one sentence
2. **Walk through the code**: Explain step-by-step what happens
3. **Review the code**: Compare the code to existing patterns
4. **Highlight a gotcha**: What's a common mistake or misconception?

Keep explanations conversational. For complex concepts, use multiple analogies.