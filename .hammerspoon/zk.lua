hs.hotkey.bind({ "ctrl", "cmd" }, "L", function()
  hs.application.launchOrFocus("Alacritty")

  local command = "~/dotfiles/scripts/zk.sh"

  hs.execute(command, true)
end)
