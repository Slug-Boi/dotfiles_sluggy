-- ~/.config/yazi/init.lua
require("full-border"):setup({
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED,
})

require("copy-file-contents"):setup({
  clipboard_cmd = "macos",
  append_char = "\n",
  notification = true,
})

