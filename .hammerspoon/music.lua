local function connectBluetoothDevice(name)
	local address = "2c-2b-f9-54-97-f1" -- LG SJ4
	local command = string.format("/opt/homebrew/bin/blueutil --connect %s", address)
	local success = hs.execute(command, true)

	if success then
		hs.alert.show("Подключено: " .. name)
	else
		hs.alert.show("Ошибка подключения")
	end
end

hs.hotkey.bind({ "cmd", "ctrl" }, "M", function()
	connectBluetoothDevice("LG SJ4")
end)
