return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- improved 'a' and 'i' motions
      local ai = require 'mini.ai'
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
          f = ai.gen_spec.treesitter { a = { '@function.outer', '@method.outer' }, i = { '@function.inner', '@method.outer' } }, -- function
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },                                                 -- class
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },                                                    -- tags
          d = { '%f[%d]%d+' },                                                                                                   -- digits
          e = {                                                                                                                  -- word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%s][%l%d]+%f[^%l%d]', '%f[%p][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
        },
      }
      -- add/delete/replace surrounding characters ()/{}/[]/""/''
      require('mini.surround').setup()
      -- use alt to move lines around
      require('mini.move').setup()
      -- automatically put in pairs e.g. ()
      -- require('mini.pairs').setup()

      -- use '[' and ']' to jump back and forward between various thins 'q' for quickfix is good
      require('mini.bracketed').setup()

      -- Replace gitsigns
      require('mini.git').setup()
      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = { add = '+', change = '~', delete = '-' },
          priority = 1,
        },
      }

      -- Highilight word on hover throughout document
      require('mini.cursorword').setup { delay = 500 }

      -- Extra functionality (including more text objects)
      require('mini.extra').setup()

      -- Extend f, F, t, T accross multiple lines
      -- require('mini.jump').setup()

      -- Icon Provider, similar to web-dev-icons but better
      -- NOTE: web-dev-icons is still a dependency of telescope
      require('mini.icons').setup()

      -- Nice starter screen
      require('mini.starter').setup()

      -- Session manager
      -- require('mini.sessions').setup()

      -- Simple file explorer (with toggle mapped to <leader>fd)
      -- require('mini.files').setup()
      -- vim.keymap.set('n', '<leader>fd', ':lua if not MiniFiles.close() then MiniFiles.open(...) end<CR>', { desc = 'Open [F]ile [D]irectory' })

      -- simple indent line only showing current scope
      require('mini.indentscope').setup { draw = { delay = 20, animation = require('mini.indentscope').gen_animation.none() } }

      -- Nicer tabline, not that I really use tabs
      -- require('mini.tabline').setup { set_vim_settings = false }

      -- stuatusline, default with macro recorsding indicator
      require('mini.statusline').setup {
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local location = MiniStatusline.section_location { trunc_width = 75 }
            local search = MiniStatusline.section_searchcount { trunc_width = 75 }
            local recording = vim.fn.reg_recording()

            return MiniStatusline.combine_groups {
              { hl = mode_hl,                 strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
              '%<', -- Mark general truncate point

              -- Shows filename unless a macro recoding is in progress, shows macro instead
              { hl = 'MiniStatuslineFilename', strings = { recording == '' and filename or string.format('Recording @%s', recording) } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { search, location } },
            }
          end,
        },
      }

      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
