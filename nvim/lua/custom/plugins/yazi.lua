-- yazi.lua
-- 一个用于yazi终端文件管理器的Neovim插件配置

return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  dependencies = {
    'folke/snacks.nvim', -- 必需的依赖
    lazy = true,
  },
  keys = {
    -- Yazi keymaps based on official recommendations
    {
      '<leader>y',
      '<cmd>Yazi<cr>',
      desc = 'Open [Y]azi at current file',
      mode = { 'n', 'v' },
    },
    {
      '<leader>Y',
      '<cmd>Yazi cwd<cr>',
      desc = 'Open [Y]azi at CWD',
    },
    {
      '<leader>ty',
      '<cmd>Yazi toggle<cr>',
      desc = '[T]oggle [Y]azi session',
    },
  },
  opts = {
    -- 是否使用yazi替代netrw（打开目录时）
    open_for_directories = false,

    -- 浮动窗口缩放因子，1表示100%，0.9表示90%
    floating_window_scaling_factor = 0.9,

    -- yazi浮动窗口的透明度(0-100)
    yazi_floating_window_winblend = 0,

    -- 日志级别，用于调试问题
    log_level = vim.log.levels.OFF,

    -- 按键映射配置
    keymaps = {
      show_help = '<f1>',
    },
  },
  -- 如果启用了open_for_directories，建议添加以下配置
  -- init = function()
  --   vim.g.loaded_netrw = 1
  --   vim.g.loaded_netrwPlugin = 1
  -- end,
}
