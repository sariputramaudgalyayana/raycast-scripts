#!/bin/zsh

# @raycast.schemaVersion 1
# @raycast.title Mic Toggle
# @raycast.mode compact
# @raycast.packageName My Scripts
# @raycast.description Cycle audio input: built-in → iPhone → connected mic
# @raycast.icon 🎙️

SAS=/opt/homebrew/bin/SwitchAudioSource
[[ -x "$SAS" ]] || { echo "SwitchAudioSource missing — brew install switchaudio-osx"; exit 1; }

# Virtual/aggregate plumbing, not real mics
skip='virtual|aggregate|multi-output|loopback|blackhole|soundflower|zoomaudio|teams'
builtin_re='macbook.*microphone|built-in'
phone_re='iphone|ipad'

typeset -a names icons
add() { names+=("$1"); icons+=("$2") }

# Ordered cycle: built-in first, then the phone, then anything plugged in
typeset -a bi ph ext
while IFS= read -r dev; do
  [[ -z "$dev" ]] && continue
  low="${dev:l}"
  [[ "$low" =~ $skip ]] && continue
  if [[ "$low" =~ $builtin_re ]]; then bi+=("$dev")
  elif [[ "$low" =~ $phone_re ]]; then ph+=("$dev")
  else ext+=("$dev")
  fi
done < <("$SAS" -a -t input)

for d in $bi;  do add "$d" "💻"; done
for d in $ph;  do add "$d" "📱"; done
for d in $ext; do add "$d" "🎤"; done

(( ${#names} )) || { echo "No usable input devices"; exit 1; }

current=$("$SAS" -t input -c)

# Next device after the current one; wrap around, and start at the top if the
# current device isn't in the cycle (e.g. a virtual device was selected)
next=1
for i in {1..${#names}}; do
  if [[ "${names[$i]}" == "$current" ]]; then
    next=$(( i % ${#names} + 1 ))
    break
  fi
done

if (( ${#names} == 1 )); then
  echo "${icons[1]} ${names[1]} (only input)"
  exit 0
fi

"$SAS" -t input -s "${names[$next]}" >/dev/null || {
  echo "Failed to switch to ${names[$next]}"; exit 1
}
echo "${icons[$next]} ${names[$next]}"
