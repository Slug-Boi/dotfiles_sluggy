return {
  setup = function(on_attach)
    -- Configure FSI to open in vertical split on the RIGHT side
    vim.g["fsharp#fsi_window_command"] = "rightbelow vnew"

    -- Set syntax highlighting for FSI buffers
    vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
      pattern = "term://*dotnet fsi*",
      callback = function(args)
        vim.schedule(function()
          vim.bo[args.buf].filetype = "fsharp"
          vim.bo[args.buf].syntax = "fsharp"
        end)
      end,
      desc = "Set FSI buffer to fsharp filetype"
    })

    -- Setup ionide
    require("ionide").setup({
      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })
  end
}


-- return {
--   -- server_name = "fsautocomplete",
--   setup = function(on_attach)
--     local lspconfig = require("lspconfig")
--     local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
--     lspconfig.fsautocomplete.setup(require("ionide").setup({
--       on_attach = on_attach,
--       capabilities = capabilities,
--       filetypes = { "fsharp" },
--       root_dir = lspconfig.util.root_pattern("*.fsproj", "*.sln", ".git"),
--       -- dotnetRoot = "/Users/slugboi/.nix-profile/bin",
--       cmd = { "fsautocomplete" }
--     })
--     )
--   end
-- }
