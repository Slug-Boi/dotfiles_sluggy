local u = require("utils")

-- Insert blank line above
u.nmap("<S-Enter>", "o<ESC>")
u.nmap("<C-Enter>", "o<ESC>k")
