vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      --vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
vim.lsp.handlers['textDocument/references'] = function(err, result, ctx, config)
  config = config or {}
  config.title = 'References'
  config.window = {
    border = 'rounded',
    style = 'minimal'
  }
  return vim.lsp.util.show_references(result, ctx, config)
end

-- Diagnostics
vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true

  -- Alternatively, customize specific options
  --virtual_lines = {
  -- Only show virtual line diagnostics for the current cursor line
  -- current_line = true,
  --},
})
