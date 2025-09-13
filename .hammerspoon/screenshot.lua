hs.hotkey.bind({ "cmd", "shift" }, "4", function()
	hs.eventtap.keyStroke({ "cmd", "shift", "ctrl" }, "4")
end)

hs.hotkey.bind({ "cmd", "shift" }, "2", function()
	local file = os.date("~/Screenshots/screenshot-%Y%m%d-%H%M%S.png")
	hs.execute("screencapture -i " .. file)
	hs.execute("open -a Preview " .. file)
end)
