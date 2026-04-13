local u = require("utils")

local lsp = vim.lsp
local api = vim.api

local utils = {}

function utils.formatting()
  local bufnr = api.nvim_get_current_buf()
  -- Loop all the clients and use their formatting
  for _, client in ipairs(lsp.get_clients()) do
    if client.name == "null-ls" or client.name == "clangd" then
      return
    end
    if client.supports_method("textDocument/formatting") then
      local params = lsp.util.make_formatting_params()
      local result, err = client.request_sync("textDocument/formatting", params, 5000, bufnr)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        vim.notify("global.lsp.formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      if result and result.result then
        local offset_encoding = client.offset_encoding
        lsp.util.apply_text_edits(result.result, bufnr, offset_encoding)
      end
    end
  end
end

function utils.custom_hover()
  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request_all(bufnr, 'textDocument/hover', params, function(results)
    if not results or vim.tbl_isempty(results) then
      vim.notify("No hover information available", vim.log.levels.INFO)
      return
    end

    -- Get the first result that has hover content
    local result = nil
    for client_id, res in pairs(results) do
      if res and res.result and res.result.contents then
        -- Check if contents is not empty
        local contents = res.result.contents
        if (type(contents) == 'string' and contents ~= '') or
            (type(contents) == 'table' and (contents.value or #contents > 0)) then
          result = res
          break
        end
      end
    end

    if not result then
      vim.notify("No hover content found", vim.log.levels.INFO)
      return
    end

    -- Convert to markdown lines
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.result.contents)
    if not markdown_lines or #markdown_lines == 0 then
      vim.notify("Empty hover content", vim.log.levels.INFO)
      return
    end

    -- Use the util function that we know works with borders
    vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', {
      border = 'rounded',
      focusable = false,
      max_width = 80,
      max_height = 25,
    })
  end)
end

function utils.test_border()
  local bufnr = vim.api.nvim_get_current_buf()
  local markdown_lines = {
    "# Test Hover",
    "This is a test of the border system",
    "- Item 1",
    "- Item 2"
  }

  vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', {
    border = 'rounded',
    focusable = false,
    max_width = 60,
  })
end

function utils.on_attach(client, bufnr)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.format({ async = true})")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua require('plugins.lsp.lsp-utils').custom_hover()") -- Updated to use custom hover
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  vim.cmd("command! LspFormat lua global.lsp.formatting()")

  u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  u.buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
  u.buf_map(bufnr, "n", "gI", ":LspImplementation<CR>")
  u.buf_map(bufnr, "n", "H", ":LspHover<CR>") -- This now uses the custom hover
  u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  u.buf_map(bufnr, "n", "<Leader>lr", ":LspRename<CR>")
  u.buf_map(bufnr, "n", "<Leader>la", ":LspCodeAction<CR>")
  u.buf_map(bufnr, "n", "<Leader>ld", ":LspDiagLine<CR>")
  u.buf_map(bufnr, "i", "<Leader>lh", "<cmd> LspSignatureHelp<CR>")
  -- Temporary buf call to avoid stalling formatter lsp call on save
  u.buf_map(bufnr, "n", "<Leader>cf", ":LspFormatting<CR>")

  if client.supports_method("textDocument/formatting") then
    vim.cmd("autocmd BufWritePre <buffer> lua global.lsp.formatting()")
  end

  -- if client.supports_method("textDocument/completion") then
  --   vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  --   u.buf_map(bufnr, "i", "<C-Space>", "<C-x><C-o>")
  -- end
end

function utils.merge_arrays(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

function utils.load_servers(servers)
  local loaded = {}

  for _, config in ipairs(servers) do
    loaded[config] = require("plugins.lsp." .. config)
  end

  return loaded
end

return utils
