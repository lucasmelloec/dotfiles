-- [[ Setting options ]]
-- For more options, you can see `:help option-list`

vim.opt.backup = false
vim.opt.breakindent = true -- Enable break indent
vim.opt.clipboard = nil -- Keep clipboard separated between OS and Neovim.
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.formatoptions = 'jcroqlnt' -- tcqj
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.ignorecase = true
vim.opt.inccommand = 'nosplit' -- Preview substitutions live
vim.opt.list = true -- Show some invisible characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.number = true -- Make line numbers default
vim.opt.pumblend = 10 -- Popup blend (transparency)
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Add relative line numbers, to help with jumping.
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shortmess:append { W = true, I = true, c = true, C = true } -- Use less enters
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.sidescrolloff = 10 -- Coluns of context
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.smartcase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartindent = true -- Add indents automatically
vim.opt.spelllang = { 'en', 'pt_br' }
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true -- Put new windows right of current
vim.opt.swapfile = false
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time. Displays which-key popup sooner
vim.opt.undodir = vim.fn.stdpath('state') .. '/undodir'
vim.opt.undofile = true -- Save undo history
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- Decrease update time
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
vim.opt.wrap = false -- Disable line wrap
vim.opt.completeopt = 'menu,menuone,noinsert'
-- vim: ts=2 sts=2 sw=2 et
