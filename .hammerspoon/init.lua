require('app-launcher')

hs.hotkey.bind({ "cmd", "ctrl" }, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
