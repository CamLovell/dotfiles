return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
      },
    }

    vim.keymap.set('n', '<leader>tt', '<cmd>lua require("neotest").watch.toggle(vim.fn.expand("%"))<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>tr', '<cmd>lua require("neotest").run.run()<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>tw', '<cmd>lua require("neotest").watch.watch()<CR>', { noremap = true, silent = true })
  end,
}
