-- [[ Setting options ]]
-- See `:help vim.o`

-- Make relative line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- line wrapping settings
vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.ruler = false

-- tell Neovim we have a nerd font
vim.g.have_nerd_font = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Mode in status line, dont need to show
vim.opt.showmode = false

-- Save undo history
vim.opt.undofile = true

-- Default tab/space behaviour
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Enable all filetype plugins
vim.cmd 'filetype plugin indent on'

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.smartindent = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
vim.opt.fillchars = 'eob: '

-- show line which cursor is on
vim.opt.cursorline = false

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Split windows down and right
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Make sure we get good colours
vim.opt.termguicolors = true

-- Set command bar to 0 height
vim.opt.cmdheight = 0

-- Disable auto comment on enter - setting formatoptions directly doesnt wokr
-- you must use this auto command to set it on file load
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Auto command to start terminal in insert mode
local start_terminal_insert = vim.schedule_wrap(function(data)
  -- Try to start terminal mode only if target terminal is current
  if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == 'terminal') then
    return
  end
  vim.cmd 'startinsert'
end)
vim.api.nvim_create_autocmd('TermOpen', { pattern = 'term://*', callback = start_terminal_insert, desc = 'Start builtin terminal in Insert mode' })

vim.diagnostic.config { virtual_text = true }
