return {
  'https://github.com/fresh2dev/zellij.vim',
  lazy = false,
  init = function()
  end,

  config = function()
    local u = require('utils')

    u.nmap("<leader>zf", "<cmd>ZellijNewPane<cr>")
    u.nmap("<leader>zs", "<cmd>ZellijNewPaneSplit<cr>")
    u.nmap("<leader>zz", "<cmd>ZellijNewPaneVSplit<cr>")
    -- Options:
    -- vim.g.zelli_navigator_move_focus_or_tab = 1
    -- vim.g.zellij_navigator_no_default_mappings = 1
  end,
}
