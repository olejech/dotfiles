local M = {}

local tabKeyCode = hs.keycodes.map["tab"]

-- hs.hotkey can't override the system app switcher, an eventtap can.
local blocker = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
	local flags = event:getFlags()
	if event:getKeyCode() == tabKeyCode and flags.cmd and not flags.alt and not flags.ctrl then
		return true
	end
	return false
end)

local suspended = false

local function toggleBlocker()
	if blocker:isEnabled() then
		blocker:stop()
		hs.alert.show("Cmd+Tab enabled")
	else
		blocker:start()
		hs.alert.show("Cmd+Tab blocked")
	end
end

-- An active keyboard tap holds back every key event, including synthetic
-- ones, until its callback runs on the main thread. Code that busy-waits on
-- the main thread for a keystroke to take effect (source-replacer) would
-- deadlock against it, so such code pauses the blocker while it runs.
function M.suspend()
	suspended = blocker:isEnabled()
	blocker:stop()
end

function M.resume()
	if suspended then
		blocker:start()
		suspended = false
	end
end

-- hs.hotkey.bind({ "ctrl", "cmd" }, "T", toggleBlocker)

blocker:start()

return M
