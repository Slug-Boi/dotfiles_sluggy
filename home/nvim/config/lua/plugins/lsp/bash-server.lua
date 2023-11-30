local B = {
  setup = function(on_attach)
    local lspconfig = require("lspconfig")

    lspconfig.bashls.setup({
      on_attach = on_attach
    })
  end,
}

return B
