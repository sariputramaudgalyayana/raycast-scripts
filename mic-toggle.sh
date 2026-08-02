#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.title Mic Toggle
# @raycast.mode compact
# @raycast.packageName My Scripts
# @raycast.description Switch audio input between iPhone and MacBook mic
# @raycast.icon 🎙️

SAS=/opt/homebrew/bin/SwitchAudioSource

current=$("$SAS" -t input -c)
# Match on "iphone" — the Continuity device name contains a curly apostrophe
iphone=$("$SAS" -a -t input | grep -i iphone | head -1)

if [[ -z "$iphone" ]]; then
  echo "No iPhone mic — wake the phone, keep it nearby"
  exit 1
fi

if [[ "$current" == "$iphone" ]]; then
  "$SAS" -t input -s "MacBook Air Microphone" >/dev/null
  echo "🎙️ MacBook Air"
else
  "$SAS" -t input -s "$iphone" >/dev/null
  echo "🎙️ iPhone"
fi
