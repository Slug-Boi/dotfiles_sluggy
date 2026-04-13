return {
  server_name = "nim_langserver",
  setup = function(on_attach)
    local lspconfig = require("lspconfig")


    lspconfig["nim_langserver"].setup({
      on_attach = on_attach,
    })
  end

}
