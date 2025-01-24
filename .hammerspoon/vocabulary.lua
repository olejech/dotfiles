local scriptPath = "~/dotfiles/scripts/vocabulary.sh"

local function saveToMarkdownFile(text)
  if text and text ~= "" then
    local command = string.format("%s '%s'", scriptPath, text)
    local success = hs.execute(command, true)
    if success then
      hs.alert.show("Saved: " .. text)
    else
      hs.alert.show("Error: can't execute script")
    end
  end
end

hs.hotkey.bind({ "cmd", "ctrl" }, "S", function()
  local originalClipboard = hs.pasteboard.getContents()
  hs.eventtap.keyStroke({ "cmd" }, "C")
  hs.timer.doAfter(0.1, function()
    local selectedText = hs.pasteboard.getContents()
    saveToMarkdownFile(selectedText)
    hs.pasteboard.setContents(originalClipboard)
  end)
end)
