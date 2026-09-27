local sourceLabels = {
	["com.apple.keylayout.US"] = "EN",
	["com.apple.keylayout.RussianWin"] = "RU",
}

local function currentLabel()
	local sourceID = hs.keycodes.currentSourceID()
	return sourceLabels[sourceID] or hs.keycodes.currentLayout()
end

local indicator = nil
local moveWatcher = nil

local function reposition()
	local pos = hs.mouse.absolutePosition()
	indicator:topLeft({ x = pos.x + 8, y = pos.y + 8 })
end

local function showIndicator()
	if indicator then
		return
	end

	local pos = hs.mouse.absolutePosition()
	indicator = hs.canvas.new({ x = pos.x + 8, y = pos.y + 8, w = 26, h = 16 })
	indicator:appendElements({
		{
			type = "rectangle",
			action = "fill",
			fillColor = { alpha = 0.85, red = 0.1, green = 0.1, blue = 0.1 },
			roundedRectRadii = { xRadius = 4, yRadius = 4 },
		},
		{
			type = "text",
			text = currentLabel(),
			textSize = 10,
			textColor = { white = 1 },
			textAlignment = "center",
			frame = { x = "0%", y = "12%", w = "100%", h = "76%" },
		},
	})
	indicator:level(hs.canvas.windowLevels.overlay)
	indicator:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)
	indicator:show()

	-- Only tracked while visible, so the mouse tap sits idle otherwise.
	moveWatcher = hs.eventtap.new({ hs.eventtap.event.types.mouseMoved }, function()
		reposition()
		return false
	end)
	moveWatcher:start()
end

local function hideIndicator()
	if moveWatcher then
		moveWatcher:stop()
		moveWatcher = nil
	end
	if indicator then
		indicator:delete()
		indicator = nil
	end
end

local function toggleIndicator()
	if indicator then
		hideIndicator()
	else
		showIndicator()
	end
end

hs.hotkey.bind({ "ctrl", "cmd" }, "k", toggleIndicator)

hs.keycodes.inputSourceChanged(function()
	if indicator then
		indicator[2].text = currentLabel()
	end
end)

showIndicator()
