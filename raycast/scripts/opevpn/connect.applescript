#!/usr/bin/osascript

# Note: OpenVPN v3.3+ recommended
# Install via https://openvpn.net/vpn-client/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect OpenVPN (Fixed)
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/openvpn.png
# @raycast.packageName OpenVPN
#
# Documentation:
# @raycast.description Improved OpenVPN Connect automation with better error handling.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

-- Launch OpenVPN Connect if not running
if application "OpenVPN Connect" is not running then
  tell application "OpenVPN Connect" to activate
  delay 4 -- wait for complete initialization
end if

-- Wait for menu bar item to appear
repeat with i from 1 to 10
  try
    tell application "System Events" to tell process "OpenVPN Connect"
      if exists menu bar item 1 of menu bar 2 then exit repeat
    end tell
  on error
    -- Menu bar item not ready yet
  end try
  delay 0.5
end repeat

-- Interact with OpenVPN menu
tell application "System Events" to tell process "OpenVPN Connect"
  try
    -- Click menu bar item to open menu
    click menu bar item 1 of menu bar 2
    delay 0.3
    
    -- Try to find and click Connect/Disconnect menu item
    tell menu bar item 1 of menu bar 2
      if exists menu item "Connect" of menu 1 then
        click menu item "Connect" of menu 1
        do shell script "echo 'Connecting to VPN...'"
      else if exists menu item "Disconnect" of menu 1 then
        click menu item "Disconnect" of menu 1
        delay 1
        -- Try to reconnect after disconnect
        click menu bar item 1 of menu bar 2
        delay 0.3
        if exists menu item "Connect" of menu 1 then
          click menu item "Connect" of menu 1
          do shell script "echo 'Reconnecting to VPN...'"
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
        do shell script "echo 'VPN connection initiated'"
      end if
    end if
    
  on error errorMessage
    do shell script "echo 'Error: " & errorMessage & "'"
  end try
end tell
