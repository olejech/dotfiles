InputSource = {
	US = "EN",
	RussianWin = "RU",
}

local appInputMethods = {
	["Zen"] = "US",
	["Alacritty"] = "US",
}

function applicationWatcher(appName, eventType)
	if eventType == hs.application.watcher.activated then
		local targetInputMethod = appInputMethods[appName]
		if targetInputMethod then
			hs.keycodes.currentSourceID("com.apple.keylayout." .. targetInputMethod)
		end
	end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
