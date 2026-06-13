#!/usr/bin/osascript

# Note: OpenVPN v3.3+ recommended
# Install via https://openvpn.net/vpn-client/
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect OpenVPN
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/openvpn.png
# @raycast.packageName OpenVPN
#
# Documentation:
# @raycast.description Disconnects the OpenVPN Connect client from VPN.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

if application "OpenVPN Connect" is not running then
  return "OpenVPN Connect not running"
end if

tell application "System Events" to tell process "OpenVPN Connect"
  try
    click menu item "Disconnect" of menu 1 of menu bar item 1 of menu bar 2
    return "OpenVPN disconnected"
  on error
    try
      click menu item "Disconnect" of menu 1 of menu bar item 1 of menu bar 1
      return "OpenVPN disconnected"
    on error
      return "Already disconnected"
    end try
  end try
end tell
