#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Agent Sync and Clear
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🧹
# @raycast.packageName My Scripts
# @raycast.description Archive Claude Code and Codex history to the lake, then wipe the local copies. Purges only after every transcript is verified in the archive.

set -e

/opt/homebrew/bin/brain claude sync --clear
/opt/homebrew/bin/brain codex sync --clear
