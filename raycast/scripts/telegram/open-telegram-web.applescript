#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Telegram Web
# @raycast.mode silent
# @raycast.packageName Productivity
#
# Optional parameters:
# @raycast.icon 💬
# @raycast.description Open web.telegram.org 

do shell script "open -na Helium --args --profile-directory=Default 'https://web.telegram.org'"
