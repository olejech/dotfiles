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
	local result = ""
	for _, codepoint in utf8.codes(text) do
		local char = utf8.char(codepoint)
		result = result .. (ruToEn[char] or char)
	end
	return result
end

local function convertEnToRu(text)
	local result = ""
	for i = 1, #text do
		local char = string.sub(text, i, i)
		result = result .. (enToRu[char] or char)
	end
	return result
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

hs.hotkey.bind({ "ctrl" }, "space", function()
	hs.eventtap.keyStroke({ "shift", "alt" }, "left")

	hs.eventtap.keyStroke({ "cmd" }, "c")

	local clipboard = hs.pasteboard.getContents()
	if clipboard and clipboard ~= "" then
		local converted = convert(clipboard)

		hs.pasteboard.setContents(converted)
		hs.eventtap.keyStroke({ "cmd" }, "v")
	end
end)
