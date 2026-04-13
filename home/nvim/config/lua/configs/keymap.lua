local u = require("utils")

-- Insert blank line above
u.nmap("<S-Enter>", "o<ESC>")
u.nmap("<C-Enter>", "o<ESC>k")
vim.keymap.set('n', '<leader>cc', '"+yy', { desc = "Copy line to system clipboard" })
vim.keymap.set('v', '<leader>cc', '"+y', { desc = "Copy selection to system clipboard" })
