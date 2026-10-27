#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Desktop to Brain
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📥

# Every location comes from ~/.zshenv, which zsh reads; bash would not.
[[ -n ${BRAIN_VAULT//[[:space:]]/} ]] || {
    print -u2 -r -- "BRAIN_VAULT is not set: the vault whose inbox Desktop and Downloads are swept into"
    exit 2
}

/opt/homebrew/bin/brain files inbox
