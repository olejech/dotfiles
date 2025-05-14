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

tell application "System Events"
	tell process "OpenVPN Connect"
		try
			click menu bar item 1 of menu bar 2
			delay 0.3 -- Небольшая задержка для прогрузки меню

			set vpnMenu to menu 1 of menu bar item 1 of menu bar 2
			if exists menu item "Disconnect" of vpnMenu then
				click menu item "Disconnect" of vpnMenu
        return "OpenVPN disconnected"
			else
				return "Already disconnected or menu item not found"
			end if
		on error errMsg
			return "Error: " & errMsg
		end try
	end tell
end tell
