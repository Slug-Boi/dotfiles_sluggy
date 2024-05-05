local opts = {
  -- Rust tools options
  tools = {
    enable_clippy = true,
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    default_settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy"
        },
        cargo = {
          buildScripts = {
            enable = true
          }
        }
      }
    }
  },
}


return {
  server_name = {},
  dependencies = {
    {
      "mrcjkb/rustaceanvim",
      version = "^4",
      lazy = false,
    }
  },
  setup = function(on_attach)
    opts.server.on_attach = on_attach -- Add the callback to the object
    vim.g.rustaceanvim = opts
  end
}
