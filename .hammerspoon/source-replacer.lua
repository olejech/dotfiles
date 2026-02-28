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

local function isWordChar(char)
	if char:match("[%w]") then
		return true
	end
	if ruToEn[char] then
		return true
	end
	if enToRu[char] then
		return true
	end
	return false
end

local function splitLastWord(text)
	local chars = {}
	for _, codepoint in utf8.codes(text) do
		chars[#chars + 1] = utf8.char(codepoint)
	end

	local wordEnd = #chars
	while wordEnd > 0 and not isWordChar(chars[wordEnd]) do
		wordEnd = wordEnd - 1
	end

	if wordEnd == 0 then
		return nil
	end

	local wordStart = wordEnd
	while wordStart > 1 and isWordChar(chars[wordStart - 1]) do
		wordStart = wordStart - 1
	end

	return table.concat(chars, "", 1, wordStart - 1),
		table.concat(chars, "", wordStart, wordEnd),
		table.concat(chars, "", wordEnd + 1)
end

hs.hotkey.bind({ "ctrl" }, "space", function()
	local originalClipboard = hs.pasteboard.getContents()

	hs.eventtap.keyStroke({ "shift", "cmd" }, "left")
	hs.eventtap.keyStroke({ "cmd" }, "c")

	hs.timer.doAfter(0.05, function()
		local lineText = hs.pasteboard.getContents()

		if not lineText or lineText == "" then
			hs.eventtap.keyStroke({}, "right")
			hs.pasteboard.setContents(originalClipboard)
			return
		end

		local prefix, word, suffix = splitLastWord(lineText)

		if not word then
			hs.eventtap.keyStroke({}, "right")
			hs.pasteboard.setContents(originalClipboard)
			return
		end

		local newLine = prefix .. convert(word) .. suffix

		hs.pasteboard.setContents(newLine)
		hs.eventtap.keyStroke({ "cmd" }, "v")

		hs.timer.doAfter(0.05, function()
			hs.pasteboard.setContents(originalClipboard)
		end)
	end)
end)
