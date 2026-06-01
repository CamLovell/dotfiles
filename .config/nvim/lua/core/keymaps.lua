-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Remove serach highlight when pressing <ESC> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize windows with Alt hjkl
vim.keymap.set('n', '<C-Left>', '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Down>', '"<Cmd>resize -"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Up>', '"<Cmd>resize +"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Increase window height' })
vim.keymap.set('n', '<C-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = 'Increase window width' })

-- Keymaps for splits
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', { desc = 'Split the current window vertically' })
vim.keymap.set('n', '<leader>hs', ':split<CR>', { desc = 'Split the current window horizontally' })

-- Disable arrow keys in normal mode - LEARN VIM PROPERLY
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Slightly easier exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Copy all
vim.keymap.set('n', 'yA', 'ggVGy', { desc = 'Copy entire file' })

-- Insert lines above and below by holding Alt and pressing O or o
vim.keymap.set('n', '<M-O>', 'O<Esc>', { desc = 'Put empty line above' })
vim.keymap.set('n', '<M-o>', 'o<Esc>', { desc = 'Put empty line below' })

-- Centre cursor on screen when using half page jumps
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move half page up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move half page down' })

-- Paste without overwriting the clipboard
vim.keymap.set('n', '<leader>p', '"*p', { desc = 'Paste without overwriting clipboard' })

-- Source current file
-- vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>')

-- Lua execution
vim.keymap.set('n', '<leader>x', ':.lua<CR>')
vim.keymap.set('v', '<leader>x', ':lua<CR>')

-- TODO: Check if the following can be done "better"

-- Harpoon Keymaps
vim.keymap.set('n', '<leader>hf', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
  { desc = 'Find Hapoon Files' })
vim.keymap.set('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = 'Add Harpoon File' })
vim.keymap.set('n', '<leader>hn', '<cmd>lua require("harpoon.ui").nav_next()<CR>', { desc = 'Next harpoon file' })
vim.keymap.set('n', '<leader>hp', '<cmd>lua require("harpoon.ui").nav_prev()<CR>', { desc = 'Previous harpoon file' })

-- Markdown Keymaps
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('n', '<leader>mp', '<cmd>LivePreview start<CR>',
      { buffer = true, desc = 'Toggle markdown preview' })
  end,
})

-- Docstring generation
vim.keymap.set('n', '<leader>gd', "<cmd>lua require('neogen').generate()<CR>", { desc = '[G]enerate [D]ocumentation' })

-- Open Oil in floating mode
vim.keymap.set('n', '-', '<cmd>Oil --float<CR>', { desc = 'Open Oil in floating mode' })
