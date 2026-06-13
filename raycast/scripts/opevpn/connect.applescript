#!/usr/bin/osascript

# Note: OpenVPN v3.3+ recommended
# Install via https://openvpn.net/vpn-client/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect OpenVPN
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

set openVpnBin to "/Applications/OpenVPN Connect/OpenVPN Connect.app/Contents/MacOS/OpenVPN Connect"

-- Launch via CLI binary to avoid activation delay
if application "OpenVPN Connect" is not running then
  do shell script quoted form of openVpnBin & " --minimize &"
end if

-- Poll for menu bar readiness (250ms intervals, 8s timeout)
set isReady to false
repeat with i from 1 to 32
  try
    tell application "System Events" to tell process "OpenVPN Connect"
      if exists menu bar item 1 of menu bar 2 then
        set isReady to true
        exit repeat
      end if
    end tell
  end try
  delay 0.25
end repeat

if not isReady then
  do shell script "echo 'OpenVPN Connect menu bar not ready'"
  return
end if

-- Click menu items directly without opening the menu first
tell application "System Events" to tell process "OpenVPN Connect"
  try
    tell menu bar item 1 of menu bar 2
      if exists menu item "Connect" of menu 1 then
        click menu item "Connect" of menu 1
        do shell script "echo 'Connecting to VPN...'"
      else if exists menu item "Disconnect" of menu 1 then
        click menu item "Disconnect" of menu 1
        do shell script "echo 'Disconnected from VPN'"
      else
        do shell script "echo 'No Connect/Disconnect option found'"
      end if
    end tell
  on error errorMessage
    do shell script "echo 'Error: " & errorMessage & "'"
  end try
end tell
