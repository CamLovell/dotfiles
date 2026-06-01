-- [[ Configure Treesitter ]]
return {
  {
    'lewis6991/ts-install.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('ts-install').setup({
        auto_install = true,
        auto_update = true,
        ignore_install = { 'dockerfile' },
      })
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    dependencies = {
      -- 'nvim-treesitter/nvim-treesitter-context',
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    },
    config = function()
      require('nvim-treesitter').setup()

      local max_filesize = 200 * 1024 -- 200 KB

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)

          if not lang then
            return
          end

          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return
          end

          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(buf, lang)
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
        desc = 'Enable treesitter highlighting',
      })
    end,
  },
}
