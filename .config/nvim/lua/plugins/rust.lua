return {
  {
    'mrcjkb/rustaceanvim',
    -- enabled = false,
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    -- enabled = false,
    config = function()
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          on_attach = function(client, bufnr)
            vim.keymap.set('n', '<leader>ca', function()
              vim.cmd.RustLsp 'codeAction'
            end, { silent = true, buffer = bufnr })
            vim.keymap.set('n', '<leader>rd', function()
              vim.cmd.RustLsp 'openDocs'
            end, { silent = true, buffer = bufnr })
          end,
          default_settings = {
            ['rust-analyzer'] = {
              -- cargo = {
              --   features = 'all',
              -- },
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    opts = {},
  },
}
