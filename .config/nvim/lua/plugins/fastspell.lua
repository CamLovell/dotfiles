return {
  "lucaSartore/fastspell.nvim",
  enabled = false,
  -- automatically run the installation script on windows and linux)
  -- if this doesn't work for some reason, you can
  build = function()
    local base_path = vim.fn.stdpath("data") .. "/lazy/fastspell.nvim"
    local cmd = base_path .. "/lua/scripts/install.sh"
    vim.system({ cmd })
  end,

  ft = { "markdown" },

  config = function()
    local fastspell = require("fastspell")

    -- call setup to initialize fastspell
    fastspell.setup({
      cspell_json_file_path = vim.fn.stdpath("config") .. "/cspell.json"
    })

    -- decide when to run the spell checking (see :help events for full list)
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter", "WinScrolled" }, {
      callback = function(_)
        if vim.bo.filetype ~= "markdown" then
          return
        end
        -- decide the area in your buffer that will be checked. This is the default configuration,
        -- and look for spelling mistakes ONLY in the lines of the bugger that are currently displayed
        -- for more advanced configurations see the section bellow
        local first_line = vim.fn.line('w0') - 1
        local last_line = vim.fn.line('w$')
        fastspell.sendSpellCheckRequest(first_line, last_line)
      end,
    })
  end,
}
