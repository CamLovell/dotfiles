return {
  "ngynkvn/gotmpl.nvim",
  opts = {},
  config = function(_, opts)
    require("gotmpl").setup(opts)
    -- gotmpl.nvim only registers `.tmpl`; Neovim has no built-in rule for `.gotmpl`.
    vim.filetype.add({ extension = { gotmpl = "gotmpl" } })
  end,
}
