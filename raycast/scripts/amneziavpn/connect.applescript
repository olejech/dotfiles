#!/usr/bin/osascript

# Note: AmneziaVPN automation script
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect Amnezia VPN (Fixed)
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/icon.png
# @raycast.packageName Amnezia VPN
#
# Documentation:
# @raycast.description Improved AmneziaVPN automation with better error handling.

-- Launch AmneziaVPN if not running
if application "AmneziaVPN" is not running then
  tell application "AmneziaVPN" to activate
  delay 4 -- wait for complete initialization
end if

-- Wait for menu bar item to appear
repeat with i from 1 to 10
  try
    tell application "System Events" to tell process "AmneziaVPN"
      if exists menu bar item 1 of menu bar 2 then exit repeat
    end tell
  on error
    -- Menu bar item not ready yet
  end try
  delay 0.5
end repeat

-- Interact with AmneziaVPN menu
tell application "System Events" to tell process "AmneziaVPN"
  try
    -- Click menu bar item to open menu
    click menu bar item 1 of menu bar 2
    delay 0.3
    
    -- Try to find and click Connect/Disconnect menu item
    tell menu bar item 1 of menu bar 2
      if exists menu item "Connect" of menu 1 then
        click menu item "Connect" of menu 1
        do shell script "echo 'Connecting to AmneziaVPN...'"
      else if exists menu item "Disconnect" of menu 1 then
        click menu item "Disconnect" of menu 1
        delay 1
        -- Try to reconnect after disconnect
        click menu bar item 1 of menu bar 2
        delay 0.3
        if exists menu item "Connect" of menu 1 then
          click menu item "Connect" of menu 1
          do shell script "echo 'Reconnecting to AmneziaVPN...'"
        end if
      else
        do shell script "echo 'No Connect/Disconnect option found'"
        return
      end if
    end tell
    
    -- Handle any connection dialog
    delay 1
    if exists window 1 then
      if exists button 1 of window 1 then
        click button 1 of window 1
        do shell script "echo 'AmneziaVPN connection initiated'"
      end if
    end if
    
  on error errorMessage
    do shell script "echo 'Error: " & errorMessage & "'"
  end try
end tell
