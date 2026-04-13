return {
  "cshuaimin/ssr.nvim",
  -- Calling setup is optional.
  config = function()
    require("ssr").setup {
      border = "rounded",
      min_width = 50,
      min_height = 5,
      max_width = 180,
      max_height = 40,
      adjust_window = true,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<cr>",
        replace_all = "<leader><cr>",
      },
    }
    vim.keymap.set({ "n", "x" }, "<leader>xx", function() require("ssr").open() end)
  end,
}
