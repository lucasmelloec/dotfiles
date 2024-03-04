-- [[ Basic Keymaps ]]

-- Package Manager
vim.keymap.set('n', '<leader>p', '<cmd>Lazy<cr>', { desc = 'Open Package Manager' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Better up/down movement considering wrapping lines
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })

-- Move Lines disable due to tmux using same keybinds for resizing
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })

vim.keymap.set({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- new file
vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New Buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist, { desc = 'Open diagnostic Location list' })
vim.keymap.set('n', '<leader>xq', vim.diagnostic.setqflist, { desc = 'Open diagnostic Quickfix list' })

vim.keymap.set('n', '[q', function()
  pcall(vim.cmd.cprev)
end, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', function()
  pcall(vim.cmd.cnext)
end, { desc = 'Next quickfix' })

-- Terminal vim.keymap.setpings
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to left window' })
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to lower window' })
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to upper window' })
vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to right window' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
vim.keymap.set('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- windows
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete window', remap = true })
vim.keymap.set('n', '<leader>ws', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>wv', '<C-W>v', { desc = 'Split window right', remap = true })

-- tabs
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
vim.keymap.set('n', '<leader><tab>s', '<cmd>tab split<cr>', { desc = 'Split tab' })

-- Keep cursor in place when using J
vim.keymap.set('n', '<S-j>', 'mzJ`z')

-- Keep cursor in the middle of screen when using C-d/C-u
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keep cursor in the middle of screen when traversing search results
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Send content of visual selection to void when pasting over it
vim.keymap.set('x', 'gp', [["_dP]], { desc = 'Paste without replacing content in register' })

-- Send yanked content to clipboard only
vim.keymap.set({ 'n', 'v' }, 'gy', [["+y]], { desc = 'Yank into clipboard' })
vim.keymap.set('n', 'gY', [["+Y]], { desc = 'Yank line into clipboard' })

-- Send deleted content to void
vim.keymap.set({ 'n', 'v' }, 'gd', [["_d]], { desc = 'Delete content into void register' })
vim.keymap.set('n', 'gD', [["_D]], { desc = 'Delete line into void register' })

-- Disable Q key
vim.keymap.set('n', 'Q', '<nop>')

-- Make current buffer executable
vim.keymap.set('n', '<leader>bx', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Chmod +x current file' })

-- Search and replace current word
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and replace current word' })

-- vim: ts=2 sts=2 sw=2 et
