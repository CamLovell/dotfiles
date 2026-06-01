local function get_python_config()
  local url = vim.fn.trim(vim.fn.system("git ls-remote --get-url"))
  if url:lower():match("rocketboots") then
    return { "isort", "black" }
  else
    return { 'ruff_organize_imports', 'ruff_format' }
  end
end

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = get_python_config(),
        -- rust = { 'rustfmt' },
        -- javascript = { 'prettier' },
        -- json = { 'prettier --parser json' },
      },
      -- formatters = {
      --   ruff = {
      --     command = 'ruff',
      --     args = { 'format', '--line-length', '120', '--force-exclude', '--stdin-filename', '$FILENAME', '-' },
      --   },
      -- },
    },
  },
}
