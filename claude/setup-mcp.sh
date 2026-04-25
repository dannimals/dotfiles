#!/usr/bin/env bash
#
# Register Claude Code MCP servers (user-scoped).
# Run once on a new machine after install.sh.

claude mcp add xcodebuildmcp -s user -- /opt/homebrew/bin/npx -y xcodebuildmcp@latest

claude mcp add filesystem -s user -- /opt/homebrew/bin/npx -y @modelcontextprotocol/server-filesystem \
  ~/ios-client \
  ~/fcpx-panel \
  ~/swift-sdk \
  ~/swift-ui-components \
  ~/frame-tv \
  ~/swift-player

claude mcp add atlassian -s user --transport http https://mcp.atlassian.com/v1/mcp

claude mcp add github -s user --transport http https://api.githubcopilot.com/mcp/ \
  --header "Authorization: ${GITHUB_TOKEN}"
