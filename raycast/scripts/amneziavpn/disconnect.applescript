#!/usr/bin/osascript

# Note: Amnezia 
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect Amnezia VPN
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/icon.png
# @raycast.packageName Amnezia VPN

if application "AmneziaVPN" is not running then
  return "AmneziaVPN not running"
end if

tell application "System Events"
	tell process "AmneziaVPN"
		try
			click menu bar item 1 of menu bar 2
			delay 0.3 -- ждём открытия меню

			set vpnMenu to menu 1 of menu bar item 1 of menu bar 2
			if exists menu item "Disconnect" of vpnMenu then
				click menu item "Disconnect" of vpnMenu
        return "AmneziaVPN disconnected"
			else
				return "Already disconnected or menu item not found"
			end if
		on error errMsg
			return "Error: " & errMsg
		end try
	end tell
end tell
