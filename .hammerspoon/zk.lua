hs.hotkey.bind({ "ctrl", "cmd" }, "Z", function()
	hs.application.launchOrFocus("Alacritty")

	local command = "~/dotfiles/scripts/zk.sh"

	hs.execute(command, true)
end)
