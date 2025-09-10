return {
  server_name = { "pyright", "ruff" },
  server_name = { "ruff" },
  setup = function(on_attach)
    local lspconfig = require("lspconfig")

    lspconfig["pyright"].setup({
      on_attach = on_attach
    })
    lspconfig["ruff"].setup({
      on_attach = on_attach
    })
  end,
}
