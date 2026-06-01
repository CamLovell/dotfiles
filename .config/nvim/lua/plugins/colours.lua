return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_transparent_background = 0
    vim.g.gruvbox_material_foreground = 'material'
    -- vim.g.gruvbox_material_enable_italic = true
    -- vim.g.gruvbox_material_disable_italic_comment = false
    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
