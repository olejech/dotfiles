#!/usr/bin/osascript

# Note: Amnezia 
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect Amnezia VPN
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/icon.png
# @raycast.packageName Amnezia VPN

if application "AmneziaVPN" is running then
	-- no op
else
	tell application "AmneziaVPN" to activate
	delay 3 --wait for init
end if

ignoring application responses --removes 5 sec delay (via caching?)
	tell application "System Events" to tell process "AmneziaVPN" to click menu bar item 1 of menu bar 2
end ignoring
delay 0.1
do shell script "killall System\\ Events"

tell application "System Events" to tell process "AmneziaVPN" to tell menu bar item 1 of menu bar 2
	click
	get menu items of menu 1
	try
		click menu item "Connect" of menu 1
		do shell script "echo AmneziaVPN ready to connect"
	on error --menu item toggles between connect/disconnect
		# key code 53 --escape key to close menu
		do shell script "echo Already connected"
	end try
end tell
