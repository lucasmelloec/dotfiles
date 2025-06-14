local M = {}

local defaults = {
  lsp = {
    autoformat = false,
    inlay_hints = false,
  },
  ai_assist = { enabled = false, tools = {} },
  editor = {
    last_location = false,
  },
}

function M.setup(opts)
  -- Set <space> as the leader key
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.g.chaps_options = vim.tbl_deep_extend('force', defaults, opts or {})
  require('chaps.options')
  require('chaps.keymaps')
  require('chaps.lazy')

  -- If neovim was started without any argv
  if vim.fn.argc(-1) == 0 then
    -- autocmds can wait to load
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('chaps_lazy_start', { clear = true }),
      pattern = 'VeryLazy',
      callback = function()
        require('chaps.autocmds')
      end,
    })
  else
    -- load them so they affect the opened buffers
    require('chaps.autocmds')
  end
end

return M
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
