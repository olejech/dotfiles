require('app-launcher')
require('zk')

hs.hotkey.bind({ "cmd", "ctrl" }, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
