-- ~/.config/yazi/init.lua
require("relative-motions"):setup({
  show_numbers = "relative",
  show_motion = true,
})
require("full-border"):setup({
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED,
})

require("copy-file-contents"):setup({
  clipboard_cmd = "macos",
  append_char = "\n",
  notification = true,
})

