return {
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "basedpyright" },
      automatic_enable = false,
    },
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { "debugpy" },
    },
    dependencies = {
      "mason-org/mason.nvim",
    }
  }

}
