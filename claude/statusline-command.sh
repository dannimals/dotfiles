#!/bin/sh
input=$(cat)

user=$(whoami)
host=$(hostname -s)
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
# Shorten home directory to ~
dir=$(echo "$dir" | sed "s|^$HOME|~|")

model=$(echo "$input" | jq -r '.model.display_name // ""')

branch=$(git -C "$(echo "$dir" | sed "s|^~|$HOME|")" rev-parse --abbrev-ref HEAD 2>/dev/null)

used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  ctx=$(printf "ctx:%.0f%%" "$used")
else
  ctx="ctx:--"
fi

five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
limits=""
if [ -n "$five" ]; then
  limits=$(printf " 5h:%.0f%%" "$five")
fi
if [ -n "$week" ]; then
  limits="$limits$(printf " 7d:%.0f%%" "$week")"
fi

branch_str=""
if [ -n "$branch" ]; then
  branch_str=$(printf "  \033[38;5;147m(%s)\033[0m" "$branch")
fi

printf "\033[38;5;159m%s@%s\033[0m:\033[38;5;229m%s\033[0m%s  \033[38;5;157m%s\033[0m  \033[38;5;218m%s%s\033[0m" \
  "$user" "$host" "$dir" "$branch_str" "$model" "$ctx" "$limits"
