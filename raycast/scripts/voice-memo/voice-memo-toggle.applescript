#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Record Voice Memo
# @raycast.mode silent
# @raycast.packageName Productivity
#
# Optional parameters:
# @raycast.icon 🎙️
# @raycast.description Start or stop a Voice Memos recording with one shortcut

-- Launch VoiceMemos if not running
if application "VoiceMemos" is not running then
  tell application "VoiceMemos" to activate
  delay 0.3
else
  tell application "VoiceMemos" to activate
  delay 0.3
end if

-- Start new recording
tell application "System Events" to tell process "VoiceMemos"
  set frontmost to true
  keystroke "n" using command down
  delay 0.3
  display notification "Recording started" with title "Voice Memos"
end tell
