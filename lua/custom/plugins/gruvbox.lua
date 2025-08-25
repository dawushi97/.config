return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- 官方默认配置
      require('gruvbox').setup {
        terminal_colors = true, -- 添加 neovim 终端颜色
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- 搜索、差异、状态栏和错误的反向背景
        contrast = '', -- 可以是 "hard"、"soft" 或空字符串
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }

      -- 设置暗色背景
      vim.o.background = 'dark'

      -- 应用颜色方案
      vim.cmd 'colorscheme gruvbox'
    end,
  },
}
