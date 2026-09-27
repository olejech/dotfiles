local blockCmdTab = require("block-cmd-tab")

local RU = "com.apple.keylayout.RussianWin"
local US = "com.apple.keylayout.US"

local ruToEn = {
	["й"] = "q",
	["ц"] = "w",
	["у"] = "e",
	["к"] = "r",
	["е"] = "t",
	["н"] = "y",
	["г"] = "u",
	["ш"] = "i",
	["щ"] = "o",
	["з"] = "p",
	["х"] = "[",
	["ъ"] = "]",
	["ф"] = "a",
	["ы"] = "s",
	["в"] = "d",
	["а"] = "f",
	["п"] = "g",
	["р"] = "h",
	["о"] = "j",
	["л"] = "k",
	["д"] = "l",
	["ж"] = ";",
	["э"] = "'",
	["я"] = "z",
	["ч"] = "x",
	["с"] = "c",
	["м"] = "v",
	["и"] = "b",
	["т"] = "n",
	["ь"] = "m",
	["б"] = ",",
	["ю"] = ".",
	["ё"] = "`",
	["Й"] = "Q",
	["Ц"] = "W",
	["У"] = "E",
	["К"] = "R",
	["Е"] = "T",
	["Н"] = "Y",
	["Г"] = "U",
	["Ш"] = "I",
	["Щ"] = "O",
	["З"] = "P",
	["Х"] = "{",
	["Ъ"] = "}",
	["Ф"] = "A",
	["Ы"] = "S",
	["В"] = "D",
	["А"] = "F",
	["П"] = "G",
	["Р"] = "H",
	["О"] = "J",
	["Л"] = "K",
	["Д"] = "L",
	["Ж"] = ":",
	["Э"] = '"',
	["Я"] = "Z",
	["Ч"] = "X",
	["С"] = "C",
	["М"] = "V",
	["И"] = "B",
	["Т"] = "N",
	["Ь"] = "M",
	["Б"] = "<",
	["Ю"] = ">",
	["Ё"] = "~",
}

local enToRu = {}
for ru, en in pairs(ruToEn) do
	enToRu[en] = ru
end

local function convertRuToEn(text)
	local result = {}
	for _, codepoint in utf8.codes(text) do
		local char = utf8.char(codepoint)
		result[#result + 1] = ruToEn[char] or char
	end
	return table.concat(result)
end

local function convertEnToRu(text)
	local result = {}
	for i = 1, #text do
		local char = text:sub(i, i)
		result[#result + 1] = enToRu[char] or char
	end
	return table.concat(result)
end

local function convert(text)
	local current = hs.keycodes.currentSourceID()
	if current == RU then
		hs.keycodes.currentSourceID(US)
		return convertRuToEn(text)
	else
		hs.keycodes.currentSourceID(RU)
		return convertEnToRu(text)
	end
end

-- Copy the current selection and wait until the pasteboard actually updates,
-- polling changeCount instead of relying on a fixed timer. The target app
-- updates the pasteboard from its own process, so the short busy-wait here is
-- safe and returns as soon as the data is ready.
local function copySelection()
	local startCount = hs.pasteboard.changeCount()
	hs.eventtap.keyStroke({ "cmd" }, "c", 0)

	local deadline = hs.timer.secondsSinceEpoch() + 0.3
	while hs.timer.secondsSinceEpoch() < deadline do
		if hs.pasteboard.changeCount() ~= startCount then
			return hs.pasteboard.getContents()
		end
		hs.timer.usleep(2000)
	end
	return nil
end

local function replaceWord()
	local originalClipboard = hs.pasteboard.getContents()

	-- Select from the cursor back to the start of the line, then find the
	-- trailing run of non-whitespace characters ourselves. alt+shift+left
	-- (OS word-boundary selection) treats punctuation like "," as a
	-- boundary, so it would leave it out of the replacement; splitting on
	-- whitespace only fixes that.
	hs.eventtap.keyStroke({ "cmd", "shift" }, "left", 0)

	local lineBeforeCursor = copySelection()

	if not lineBeforeCursor or lineBeforeCursor == "" then
		hs.eventtap.keyStroke({}, "right", 0)
		if originalClipboard then
			hs.pasteboard.setContents(originalClipboard)
		end
		return
	end

	-- Trailing whitespace (e.g. the cursor sitting right after a space) is
	-- captured separately so it can be preserved unchanged instead of
	-- swallowing the match and leaving no word to convert.
	local word, trailingSpace = lineBeforeCursor:match("(%S+)(%s*)$")

	if not word or word == "" then
		hs.eventtap.keyStroke({}, "right", 0)
		if originalClipboard then
			hs.pasteboard.setContents(originalClipboard)
		end
		return
	end

	local prefix = lineBeforeCursor:sub(1, #lineBeforeCursor - #word - #trailingSpace)

	-- Shrink the selection back down to just the word (plus its trailing
	-- whitespace) instead of retyping the whole line: with many words in
	-- the field, resending the unchanged prefix as synthetic keystrokes is
	-- what made this slow. shift+right moves the selection's active edge
	-- (the one just extended by cmd+shift+left) back toward the cursor,
	-- shrinking from the left without touching the anchor.
	local prefixCharCount = utf8.len(prefix) or #prefix
	for _ = 1, prefixCharCount do
		hs.eventtap.keyStroke({ "shift" }, "right", 0)
	end

	-- keyStrokes sends unicode characters, so the converted text is inserted
	-- as-is regardless of the active keyboard layout, replacing the selection.
	hs.eventtap.keyStrokes(convert(word) .. trailingSpace)

	if originalClipboard then
		hs.pasteboard.setContents(originalClipboard)
	end
end

hs.hotkey.bind({ "ctrl" }, "space", function()
	blockCmdTab.suspend()
	local ok, err = pcall(replaceWord)
	blockCmdTab.resume()
	if not ok then
		error(err)
	end
end)
