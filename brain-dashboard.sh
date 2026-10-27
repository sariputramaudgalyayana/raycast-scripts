#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Brain Dashboard
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📚

# Every location comes from ~/.zshenv, which zsh reads; bash would not.
[[ -n ${BRAIN_VAULT//[[:space:]]/} ]] || {
    print -u2 -r -- "BRAIN_VAULT is not set: the vault the dashboard counts"
    exit 2
}

/opt/homebrew/bin/brain dashboard count
