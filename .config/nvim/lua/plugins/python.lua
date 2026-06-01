return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    -- branch = 'regexp',
    ft = { 'python' },
    opts = {
      -- Your options go here
      auto_refresh = true,
      dap_enabled = true,
      name = { 'venv', '.venv', '.env', 'env' },
      search = {
        dev = {
          command = "fdfind '/bin/python$' --full-path --color never ~/dev/env",
        },
      },
    },
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>ps', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>pc', '<cmd>VenvSelectCached<cr>' },
    },
  },

  {
    'danymat/neogen',
    opts = {
      languages = {
        python = {
          template = {
            annotation_convention = 'google_docstrings',
          },
        },
      },
    },
    config = true,
  },
}
