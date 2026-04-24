---
name: open-pr
description: Takes a Jira issue link, fetches its title, creates a git branch named dg/iOS-{ticket}_{short_description}, switches to it, and implements the work described in the ticket.
allowed-tools: Agent, mcp__atlassian__getJiraIssue, Bash(git *)
---

## Instructions

The user will provide a Jira issue URL or issue key (e.g. `https://jira.atlassian.com/browse/PROJ-123` or `PROJ-123`).

1. **Extract the issue key** from the URL or use it directly (format: `LETTERS-DIGITS`, e.g. `IOS-456`).

2. **Fetch the Jira issue** using `mcp__atlassian__getJiraIssue` to get the full issue summary, description, and acceptance criteria.

3. **Generate the branch name**:
   - Condense the summary to a short phrase (3–6 words), lowercase, underscores, no special chars
   - Format: `dg/iOS-{ticket}_{short_description}` (e.g. `dg/iOS-9694_fix_login_crash`)

4. **Create and switch to the branch**:
   ```
   git checkout -b dg/iOS-{ticket}_{short_description}
   ```

5. **Launch a subagent** using the `Agent` tool with `subagent_type: "general-purpose"`. Pass a self-contained prompt that includes the issue key, branch name, working directory, and these instructions:

     ```
     You are implementing a Jira ticket in the iOS client repo at /Users/danningge/ios-client (already checked out on branch {branch_name}).

     Fetch the full Jira issue using mcp__atlassian__getJiraIssue with key {issue_key} to get the description and acceptance criteria.

     Steps:
     1. Explore the codebase to understand relevant files and patterns.
     2. Make all code changes required to address the ticket (bug fix, feature, refactor, etc.).
     3. Follow existing code conventions — do not introduce new patterns beyond what the ticket requires.
     4. Do NOT commit. Leave changes unstaged/staged for the user to review.
     5. Report: list every file changed, summarize what was done, and flag anything out of scope or needing manual follow-up.
     ```

6. **After the subagent returns**, summarize its report to the user (files changed, what was done, anything flagged). Ask the user to confirm before committing.

7. **After user confirms**: stage the changed files by name, commit, push, and open a PR:
   ```
   git add <specific changed files>
   git commit -m "{IOS-ticket}: {one sentence summary}"
   git push -u origin {branch_name}
   ```
   Then create the PR:
   ```
   gh pr create --title "{IOS-ticket}: {short title}" --body "$(cat <<'EOF'
   ### [{IOS-ticket}](https://frame-io.atlassian.net/browse/{IOS-ticket})

   **Risk:** Minor | **Impact:** No Degradation

   ---

   ### What
   {brief overview of what the PR accomplishes}

   ### Why
   {why the changes were made}

   ### How
   {steps taken / approach}

   ### Looks like
   <!-- Upload screenshots or videos if applicable -->

   ### Depends on
   <!-- Link any dependent PRs from other repos -->
   EOF
   )"
   ```
   Report the PR URL when done.
