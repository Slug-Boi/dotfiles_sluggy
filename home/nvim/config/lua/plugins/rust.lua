return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    config = function()
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local utils_lsp = require("plugins.lsp.lsp-utils")

      vim.g.rustaceanvim = {
        server = {
          -- capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Use your custom on_attach function
            utils_lsp.on_attach(client, bufnr)
            
            -- You can add Rust-specific mappings here if needed
            -- For example:
            local opts = { buffer = bufnr }
            vim.keymap.set('n', '<leader>cr', ':RustRun<CR>', opts)
            vim.keymap.set('n', '<leader>ct', ':RustTest<CR>', opts)
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = true,
              cargo = {
                buildScripts = {
                  enable = true
                }
              },
              diagnostics = {
                disabled = { "unlinked-file" }
              },
              completion = {
                addSemiColonToUnit = true,
                autoimport = {
                  enable = true
                },
                postfix = {
                  enable = true
                },
                callable = {
                  signatures = {
                    enable = true
                  }
                }
              },
              inlayHints = {
                bindingModeHints = {
                  enable = true
                },
                chainingHints = {
                  enable = true
                },
                closingBraceHints = {
                  enable = true
                },
                lifetimeElisionHints = {
                  enable = "always"
                },
                maxLength = 25,
                parameterHints = {
                  enable = true
                },
                reborrowHints = {
                  enable = "always"
                },
                renderColons = true,
                typeHints = {
                  enable = true
                }
              },
              semanticHighlighting = {
                operator = {
                  specialization = {
                    enable = true
                  }
                },
                strings = {
                  enable = true
                }
              },
              lens = {
                enable = true,
                implementations = {
                  enable = true
                },
                run = {
                  enable = true
                }
              },
              files = {
                watcher = "client"
              }
            }
          }
        }
      }
    end
  }
}
