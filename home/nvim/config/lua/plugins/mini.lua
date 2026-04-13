return {
  -- Main mini plugin with completion and snippets
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Completion
      require("mini.completion").setup({
        delay = {
          completion = 100,
          info = 100,
          signature = 50,
        },
        window = {
          info = { border = 'rounded' },
          signature = { border = 'rounded' },
        },
        lsp_completion = {
          source_func = 'completefunc',
          auto_setup = true,
        }
      })

      -- Snippets
      require("mini.snippets").setup({
        mappings = {
          -- expand = '<Tab>',
          next = '<C-j>',
          previous = '<C-k>',
        },
      })
    end,
  },

  -- Mini icons for UI enhancements
  {
    "echasnovski/mini.icons",
    event = "VeryLazy",
    config = function()
      require("mini.icons").setup({
        -- Customize icons if needed
      })
    end,
  },

  -- Hipatterns for better highlighting
  {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",
    config = function()
      require("mini.hipatterns").setup({
        highlighters = {
          -- Add hex color highlighting
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      })
    end,
  },
}
