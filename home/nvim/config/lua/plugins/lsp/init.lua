local lu = require("plugins.lsp.lsp-utils")
local lsp = vim.lsp

local border_opts = { border = "single", focusable = false, scope = "line" }

vim.diagnostic.config({ virtual_text = true, float = border_opts })

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

global.lsp = {
  border_opts = border_opts,
  formatting = lu.formatting,
}

local opts = {
  automatic_installation = true,
  ensure_installed = {}
}

local dependencies = {
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
}

local servers = lu.load_servers({
  "bash-server",
  "c-server",
  "cmake-server",
  "csharp-server",
  "dagger-server",
  "eslint-server",
  "go-server",
  "graphql-server",
  "latex-server",
  "lua-server",
  "nix-server",
  "python-server",
  "rs-server",
  "scala-server",
  "svelte-server",
  "tailwindcss-server",
  "terraform-server",
  "ts-ls",
  "vue-server",
  "yaml-server",
})

for _, server in pairs(servers) do
  if type(server.server_name) == "table" then
    lu.merge_arrays(opts.ensure_installed, server.server_name)
  else
    table.insert(opts.ensure_installed, server.server_name)
  end

  if server.dependencies then
    lu.merge_arrays(dependencies, server.dependencies)
  end
end

-- Hide lspconfig messages
local hide_lspconfig_messages = function()
  local notify = vim.notify
  vim.notify = function(msg, ...)
    if msg:match("%[lspconfig%]") then
      return
    end

    notify(msg, ...)
  end
end

return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = dependencies,
    lazy = false,
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup(opts)

      for _, server in pairs(servers) do
        server.setup(lu.on_attach)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("AutoLspStart", {}),
        callback = function(args)
          local bufnr = args.buf
          local filetype = vim.bo[bufnr].filetype

          -- Only start LSP for valid file types (exclude help, terminal, etc.)
          if filetype ~= "" and filetype ~= "help" and filetype ~= "terminal" then
            -- Check if LSP is already started for this buffer
            local clients = vim.lsp.get_clients({ bufnr = bufnr })
            if #clients == 0 then
              vim.cmd("LspStart")
            end
          end
        end,
      })

      vim.schedule(function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
        local filetype = vim.bo[bufnr].filetype
        if filetype ~= "" and filetype ~= "help" and filetype ~= "terminal" then
          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          if #clients == 0 then
            vim.cmd("LspStart")
          end
        end
      end
    end
  end)
    end,
    init = function()
      hide_lspconfig_messages()
    end
  }
}
