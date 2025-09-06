return {
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("citruszest").setup({
        option = {
          transparent = true,
        }
      })
      vim.cmd([[colorscheme citruszest]])
      vim.cmd([[hi FloatBorder ctermbg=NONE guibg=NONE]])
    end
    -- vim.cmd([[hi FloatBorder ctermbg=NONE guibg=#1e222a guifg=#3b4252]]),
  },
}
