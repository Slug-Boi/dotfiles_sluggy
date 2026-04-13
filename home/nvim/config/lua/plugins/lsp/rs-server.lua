-- WARNING: If for some reason you get an error related to not being able to load the rust-analyzer server dynamically then try and delete ~/.local/share/nvim/mason/bin/rust_analyzer. This file may exist and be first in the path compared to the one installed correctly by nix itself.

return {
  server_name = "rust_analyzer",
  dependencies = {
    {
      "mrcjkb/rustaceanvim",
      version = "^6",
      lazy = false,
    }
  },
  setup = function(on_attach)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- require('lspconfig').rust_analyzer.setup({})
    vim.g.rustaceanvim = {
      server = {
        cmd = { "rust-analyzer" },
        on_attach = on_attach,
        capabilities = capabilities,
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
