local lu = require("plugins.lsp.lsp-utils")
local lsp = vim.lsp

local border_opts = { border = "single", focusable = false, scope = "line" }

vim.diagnostic.config({ virtual_text = true, float = border_opts })

vim.lsp.buf.hover = function()
  vim.lsp.buf.hover({ border = border_opts.border, focusable = border_opts.focusable })
end

vim.lsp.buf.signature_help = function()
  vim.lsp.buf.signature_help({ border = border_opts.border, focusable = border_opts.focusable })
end

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
  -- "WillEhrendreich/Ionide-nvim",
  "ionide/ionide-vim",
  "alaviss/nim.nvim",
}

local servers = lu.load_servers({
  "bash-server",
  "ionide-server",
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
  --"rs-server",
  "scala-server",
  "svelte-server",
  "tailwindcss-server",
  "terraform-server",
  "ts-ls",
  -- "vue-server",
  "yaml-server",
})


-- Comment back in if you wanna see if a server is returning a boolean value
-- for i, server in pairs(servers) do
--   if type(server) ~= "table" then
--     vim.notify("[lsp] Index " .. tostring(i) .. " is a " .. type(server) .. " (" .. tostring(server) .. ")", vim.log.levels.WARN)
--   end
-- end

-- for _, server in pairs(servers) do
--   if type(server.server_name) == "table" then
--     lu.merge_arrays(opts.ensure_installed, server.server_name)
--   else
--     table.insert(opts.ensure_installed, server.server_name)
--   end
--
--   if server.dependencies then
--     lu.merge_arrays(dependencies, server.dependencies)
--   end
-- end
for _, server in pairs(servers) do
  if type(server) ~= "table" then
    vim.notify("[lsp] Skipping invalid server entry: " .. tostring(server), vim.log.levels.WARN)
    goto continue
  end

  if type(server.server_name) == "table" then
    lu.merge_arrays(opts.ensure_installed, server.server_name)
  else
    table.insert(opts.ensure_installed, server.server_name)
  end

  if server.dependencies then
    lu.merge_arrays(dependencies, server.dependencies)
  end

  ::continue::
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

      -- Classic approach: Set up servers manually after Mason
      -- Wait a bit for Mason to finish installing, then set up LSP servers
      vim.defer_fn(function()
        for _, server in pairs(servers) do
          if type(server) == "table" and type(server.setup) == "function" then
            server.setup(lu.on_attach)
          end
        end

        -- Set up any other LSP servers that Mason installed but we didn't configure
        local installed_servers = require("mason-lspconfig").get_installed_servers()
        -- Build a lookup set of already-configured server names
        local configured = {}
        for _, server in pairs(servers) do
          if type(server) == "table" and server.server_name then
            if type(server.server_name) == "table" then
              for _, name in ipairs(server.server_name) do
                configured[name] = true
              end
            else
              configured[server.server_name] = true
            end
          end
        end
        for _, server_name in ipairs(installed_servers) do
          if not configured[server_name] then
            require("lspconfig")[server_name].setup({
              on_attach = lu.on_attach,
              capabilities = vim.lsp.protocol.make_client_capabilities(),
            })
          end
        end
      end, 1000) -- Wait 1 second for Mason to finish

      -- Auto-start LSP for filetypes
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("LspAutoStart", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local filetype = vim.bo[bufnr].filetype

          -- Skip if LSP is already attached or for certain filetypes
          if filetype == "" or filetype == "help" or filetype == "terminal" then
            return
          end

          local clients = vim.lsp.get_clients({ bufnr = bufnr })
          if #clients == 0 then
            vim.schedule(function()
              -- For Rust files, ensure rustaceanvim is loaded
              if filetype == "rust" then
                if not package.loaded["rustaceanvim"] then
                  require("lazy").load({ plugins = { "rustaceanvim" } })
                end
                -- rustaceanvim auto-starts the LSP, so we don't need LspStart
                return
              end

              if filetype == "scala" then
                if not package.loaded["nvim-metals"] then
                  require("lazy").load({ plugins = { "nvim-metals" } })
                end
                vim.cmd("LspStart")
                return
              end

              -- For F# files, ensure Ionide is loaded
              if filetype == "fsharp" then
                if not package.loaded["ionide"] then
                  require("lazy").load({ plugins = { "Ionide-Nvim" } })
                end
                -- Manually start the LSP for F#
                vim.cmd("LspStart")
                return
              end

              -- For all other filetypes, use LspStart
              vim.cmd("LspStart")
            end)
          end
        end,
      })



      -- Also trigger LSP on BufEnter for files opened directly
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("LspBufEnter", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype ~= "" then
            local clients = vim.lsp.get_clients({ bufnr = bufnr })
            if #clients == 0 then
              vim.defer_fn(function()
                vim.cmd("LspStart")
              end, 100) -- Small delay to ensure file is fully loaded
            end
          end
        end,
      })

      -- Start LSP for any existing buffers
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
