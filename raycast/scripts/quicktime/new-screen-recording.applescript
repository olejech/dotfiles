#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Record Video Screen
# @raycast.mode silent
# @raycast.packageName Productivity
#
# Optional parameters:
# @raycast.icon 🎥
# @raycast.description Open QuickTime Player and start a new screen recording (press record yourself)

tell application "QuickTime Player" to activate
delay 0.5

tell application "System Events" to tell process "QuickTime Player"
  set frontmost to true

  -- Dismiss the "Open" file picker window QuickTime shows on launch
  try
    click button "Cancel" of window 1
    delay 0.3
  end try

  click menu item "New Screen Recording" of menu "File" of menu bar 1
end tell
