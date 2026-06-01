return {
  'github/copilot.vim',
  config = function()
    -- Start with Copilot disabled
    vim.cmd.Copilot 'disable'

    -- Toggle copilot
    function ToggleCopilot()
      local status = vim.fn['copilot#Enabled']()
      if status == 1 then
        vim.cmd 'Copilot disable'
        print 'Copilot Disabled'
      else
        vim.cmd 'Copilot enable'
        print 'Copilot Enabled'
      end
    end

    vim.api.nvim_set_keymap('n', '<leader>cp', '<cmd>lua ToggleCopilot()<CR>', { noremap = true, silent = true })
  end,
}
