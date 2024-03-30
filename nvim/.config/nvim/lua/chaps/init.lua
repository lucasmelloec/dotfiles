local M = {}

local defaults = {
  lsp = {
    autoformat = false,
    inlay_hints = false,
  },
  ai_assist = {
    enabled = false,
    tools = {},
  },
}
local options

function M.setup(opts)
  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  options = vim.tbl_deep_extend('force', defaults, opts or {})
  require 'chaps.options'
  require 'chaps.keymaps'
  require 'chaps.autocmds'
  require 'chaps.plugins'
end

return M
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
