--Set <space> as the leader key local and global
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Suppress vim.tbl_flatten deprecation warning (from plugins not yet updated)
-- Remove this once nvim-treesitter-textobjects is updated
local original_deprecate = vim.deprecate
vim.deprecate = function(name, alternative, version, plugin, backtrace)
  if name == 'vim.tbl_flatten' then
    return
  end
  return original_deprecate(name, alternative, version, plugin, backtrace)
end

-- Set custom keymaps and options
require 'core.keymaps'
require 'core.options'

-- Install lazy and all the plugins
require 'core.lazy'
require 'core.lsp'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Choose where to put help window (bottom or right) depending on window width
-- takes into account window NOT whole session so if you have multiple vertical
-- splits it will open it up on the bottom where it is easier to read
vim.api.nvim_create_autocmd({ 'WinNew', 'BufWinEnter' }, {
  callback = function()
    if vim.bo.filetype ~= 'help' or vim.api.nvim_win_get_config(0).relative ~= '' then
      return
    end

    -- Current window (not screen/session) width
    -- local width = vim.api.nvim_win_get_width(0)
    local width = vim.o.columns
    if width > 100 then
      vim.cmd 'wincmd L' -- Move help to the right if screen is wide
    else
      vim.cmd 'wincmd J' -- Move help to the bottom if screen is narrow
    end
  end,
})


-- Any file without an extension in waybar dir, set to jsonc
vim.filetype.add({
  pattern = {
    -- top-level files
    ["/home/[^/]+/%.config/waybar/[^/%.]+"] = "jsonc",
    -- subdirectory files
    ["/home/[^/]+/%.config/waybar/.*/[^/%.]+"] = "jsonc",
  },
})



-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
