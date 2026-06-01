vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    -- Find references for the word under your cursor.
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    -- Jump to the implementation of the word under your cursor.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    -- Jump to the type of the word under your cursor.
    map('gt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    -- Fuzzy find all the symbols in your current document.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- Fuzzy find all the symbols in your current workspace
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    -- Rename the variable under your cursor
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    -- Execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    -- Opens a popup that displays documentation about the word under your cursor
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- INFO: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end,
})

-- Make sure everything is aware of capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
vim.lsp.config("*", { capabilities = capabilities })

-- Look in lsp folder in config dir for available lsp configs and enable them
local scan = require("plenary.scandir")
local lsp_configs = {}
for _, file in ipairs(scan.scan_dir(vim.fn.stdpath("config") .. "/lsp", { depth = 1 })) do
  local lsp_file = file:match("^.+/(.*)%.lua$")
  if lsp_file then
    table.insert(lsp_configs, lsp_file)
  end
end
vim.lsp.enable(lsp_configs)

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer

-- Let neovim know the capabilities we have

-- Enable the following language servers
-- local servers = {
--
--   -- avoid enabling to ensure system toolchain version matches
--   -- rustaceanvim will find the system version
--   -- use `rustup component add rust_analyzer` to install
--   -- rust_analyzer = {},
--   cmake = {},
--   marksman = {},
--   lua_ls = {
--     settings = {
--       Lua = {
--         completion = {
--           callSnippet = 'Replace',
--         },
--         -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--         diagnostics = { disable = { 'missing-fields' } },
--       },
--     },
--   },
-- }
