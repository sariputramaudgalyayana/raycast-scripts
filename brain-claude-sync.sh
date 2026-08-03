#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Claude Sync and Clear
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🧹
# @raycast.packageName My Scripts
# @raycast.description Archive Claude Code history to the lake, then wipe the local copy. Purges only after every transcript is verified in the archive.

/opt/homebrew/bin/brain claude sync --clear
