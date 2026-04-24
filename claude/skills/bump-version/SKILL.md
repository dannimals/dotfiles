---
name: bump-version
description: Bumps the marketing version in Frame.io.xcodeproj/project.pbxproj by 0.1.0 (minor) by default, or 0.0.1 (patch) if the user says it's a hotfix. Shows a diff for confirmation, then creates branch dg/BumpVersion-{version} and pushes to remote.
allowed-tools: Bash, Read, Edit, Bash(gh *)
---

## Instructions

### Steps

1. **Read the current marketing version** from `Frame.io.xcodeproj/project.pbxproj`:
   - Run: `grep "MARKETING_VERSION" Frame.io.xcodeproj/project.pbxproj`
   - Identify the **dominant version** (the one appearing most frequently — typically 4 occurrences). Ignore any outlier entries at a different version (these belong to separate targets and must not be touched).

2. **Compute the new version**:
   - **Default (minor bump)**: increment the middle number by 1 and reset the patch to 0.
     - Example: `2.6.0` → `2.7.0`, `2.6.3` → `2.7.0`
   - **Hotfix** (user said "hotfix"): increment the patch number by 1 only.
     - Example: `2.6.0` → `2.6.1`, `2.6.3` → `2.6.4`

3. **Show the user a preview** — print a concise summary like:
   ```
   Marketing version: 2.6.0 → 2.6.1
   File: Frame.io.xcodeproj/project.pbxproj (4 occurrences)
   Branch: dg/BumpVersion-2.6.1

   Confirm? (yes/no)
   ```
   Wait for explicit user confirmation before making any changes.

4. **After confirmation** — apply the version bump:
   - Use the Edit tool (not sed) to replace occurrences of `MARKETING_VERSION = {old};` with `MARKETING_VERSION = {new};` in `Frame.io.xcodeproj/project.pbxproj`.
   - Only replace lines matching the dominant version identified in step 1. Do not touch entries at other versions.
   - Verify the replacement count matches expectations by re-running grep.

5. **Create the branch, commit, push, and open a PR**:
   ```
   git checkout -b dg/BumpVersion-{new_version}
   git add Frame.io.xcodeproj/project.pbxproj
   git commit -m "chore: bump marketing version to `{new_version}`"
   git push -u origin dg/BumpVersion-{new_version}
   gh pr create --title "Chore: bump marketing version to {new_version}" --body ""
   ```

6. **Report** the PR URL to the user.

### Rules
- Never touch `MARKETING_VERSION` entries that don't match the dominant version — those belong to a separate target.
- Use `Edit` with `replace_all: true` to update all matching occurrences in one call.
- The commit message format must match: `chore: bump marketing version to \`{version}\``
- The branch name is `dg/BumpVersion-{new_version}` with the full semver (e.g. `dg/BumpVersion-2.6.1`).
