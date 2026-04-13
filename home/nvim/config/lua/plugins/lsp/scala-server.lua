return {
  server_name = {}, -- Empty because Metals isn't in Mason
  dependencies = {
    "scalameta/nvim-metals",
  },
  setup = function(on_attach)
    local metals_config = require("metals").bare_config()

    metals_config.on_attach = on_attach
    metals_config.capabilities = vim.lsp.protocol.make_client_capabilities()
    metals_config.settings = metals_config.settings or {}
    vim.tbl_deep_extend("force", metals_config.settings, {
      showImplicitArguments = true,
      excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl"
      },
    })

    -- Metals handles its own LSP initialization
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
