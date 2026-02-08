return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        -- 编译选项
        compile = false,

        -- 风格选项
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},

        -- 背景和终端选项
        transparent = false,
        dimInactive = false,
        terminalColors = true,

        -- 主题选择
        theme = 'wave', -- 可选: wave, dragon, lotus
        background = {
          dark = 'wave',
          light = 'lotus',
        },

        -- 颜色自定义
        colors = {
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {},
          },
        },

        -- 自定义高亮组和插件适配
        overrides = function(colors)
          local theme = colors.theme

          return {
            -- 基本UI元素高亮
            NormalFloat = { bg = theme.ui.bg_p1 },
            FloatBorder = { bg = theme.ui.bg_p1, fg = theme.ui.bg_p1 },

            -- 适配 neo-tree
            NeoTreeNormal = { bg = theme.ui.bg },
            NeoTreeNormalNC = { bg = theme.ui.bg },
            NeoTreeEndOfBuffer = { fg = theme.ui.bg, bg = theme.ui.bg },
            NeoTreeRootName = { fg = theme.ui.special, bold = true },
            NeoTreeGitAdded = { fg = theme.vcs.added },
            NeoTreeGitModified = { fg = theme.vcs.changed },
            NeoTreeGitDeleted = { fg = theme.vcs.removed },
            NeoTreeIndentMarker = { fg = theme.ui.whitespace },
            NeoTreeSymbolicLinkTarget = { fg = theme.syn.type },

            -- 适配 toggleterm
            ToggleTerm = { bg = theme.ui.bg },
            ToggleTermBorder = { fg = theme.ui.nontext, bg = theme.ui.bg },
            Terminal = { bg = theme.ui.bg },

            -- 定义一个特殊的暗色背景用于终端
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          }
        end,
      }

      -- 设置颜色方案
      vim.cmd 'colorscheme kanagawa'

      -- 为终端添加特殊的高亮组
      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = '*',
        callback = function()
          vim.opt_local.winhighlight = 'Normal:NormalDark'
        end,
      })
    end,
  },
}
