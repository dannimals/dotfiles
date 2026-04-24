#!/usr/bin/env bash
#
# Symlink Claude Code config files into ~/.claude/

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DOTFILES="$DOTFILES_ROOT/claude"
CLAUDE_DIR="$HOME/.claude"

success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"; }
skip()    { printf "\r\033[2K  [ \033[00;36m--\033[0m ] %s (already linked)\n" "$1"; }
fail()    { printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"; }

link_claude_file() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    skip "$dst"
    return
  fi

  if [ -e "$dst" ]; then
    mv "$dst" "${dst}.backup"
    success "backed up $dst"
  fi

  ln -s "$src" "$dst"
  success "linked $dst"
}

link_claude_file "$CLAUDE_DOTFILES/settings.json"       "$CLAUDE_DIR/settings.json"
link_claude_file "$CLAUDE_DOTFILES/settings.local.json" "$CLAUDE_DIR/settings.local.json"
link_claude_file "$CLAUDE_DOTFILES/statusline-command.sh" "$CLAUDE_DIR/statusline-command.sh"

link_claude_file "$CLAUDE_DOTFILES/skills/bump-version/SKILL.md" "$CLAUDE_DIR/skills/bump-version/SKILL.md"
link_claude_file "$CLAUDE_DOTFILES/skills/open-pr/SKILL.md"      "$CLAUDE_DIR/skills/open-pr/SKILL.md"
link_claude_file "$CLAUDE_DOTFILES/skills/review-pr/SKILL.md"    "$CLAUDE_DIR/skills/review-pr/SKILL.md"

link_claude_file "$CLAUDE_DOTFILES/agents/bug-fixer.md"               "$CLAUDE_DIR/agents/bug-fixer.md"
link_claude_file "$CLAUDE_DOTFILES/agents/code-improvement-advisor.md" "$CLAUDE_DIR/agents/code-improvement-advisor.md"
