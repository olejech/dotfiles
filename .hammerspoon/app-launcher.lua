local modifiers = { "cmd", "ctrl" }
hs.hotkey.bind(modifiers, "B", function()
	hs.application.launchOrFocus("Zen")
end)

hs.hotkey.bind(modifiers, "E", function()
	hs.application.launchOrFocus("Alacritty")
end)

hs.hotkey.bind(modifiers, "C", function()
	hs.application.launchOrFocus("Calendar")
end)
