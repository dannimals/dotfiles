---
name: weekly-sum
description: Fetches all PRs opened or merged in the current week from a given GitHub repo and outputs a bullet list with a link, one-line summary, and status (In CR / Merged) for each.
allowed-tools: mcp__github__list_pull_requests, mcp__github__search_pull_requests, mcp__github__pull_request_read
---

## Instructions

The user will provide a GitHub repo (e.g. `owner/repo` or a full URL). If none is given, ask for one.

1. **Determine the date range**: the current week is Monday through today. Compute Monday's date from today.

2. **Fetch PRs**: Use `mcp__github__search_pull_requests` to find PRs in the repo created or merged since Monday:
   - Query: `repo:{owner}/{repo} created:>={YYYY-MM-DD}` for open/in-review PRs
   - Also query: `repo:{owner}/{repo} merged:>={YYYY-MM-DD}` for merged PRs
   - Deduplicate by PR number.

3. **For each PR**, determine:
   - **Link**: the HTML URL
   - **Summary**: one sentence describing what the PR does, derived from the title and body (first paragraph or description). Keep it under 12 words.
   - **Status**:
     - `merged_at` is set → **Merged**
     - `state` is `open` → **In CR**

4. **Output** a markdown bullet list, sorted by PR number descending (newest first):

   ```
   • [#{number} Title](url) — {one-line summary} · **Merged** / **In CR**
   ```

   Group into two sections if both exist:

   ```
   **Merged**
   • ...

   **In CR**
   • ...
   ```

5. If no PRs are found for the week, say so clearly.
