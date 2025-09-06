return {
"folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    animate = { enabled = true },
    bigfile = { enabled = true },
    dim = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { 
      enabled = true,
      preset = {

      header = [[
 ________  ___       ___  ___  ________      ________  ________  ___     
|\   ____\|\  \     |\  \|\  \|\   ____\    |\   __  \|\   __  \|\  \    
\ \  \___|\ \  \    \ \  \\\  \ \  \___|    \ \  \|\ /\ \  \|\  \ \  \   
 \ \_____  \ \  \    \ \  \\\  \ \  \  ___   \ \   __  \ \  \\\  \ \  \  
  \|____|\  \ \  \____\ \  \\\  \ \  \|\  \ __\ \  \|\  \ \  \\\  \ \  \ 
    ____\_\  \ \_______\ \_______\ \_______\\__\ \_______\ \_______\ \__\
   |\_________\|_______|\|_______|\|_______\|__|\|_______|\|_______|\|__|
   \|_________|                                                          
                                                                        ]],
      ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":Yazi" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "c", desc = "Config", action = ":Yazi $HOME/.config/nvim/" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    },
    debug = { enabled = true },
    gitbrowse = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    -- terminal = { enabled = true },
    toggle = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
}
