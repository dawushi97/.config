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
    -- 自定义快捷键，可以根据需要调整
    {
      '<leader>z',
      '<cmd>Yazi<cr>',
      desc = '在当前文件位置打开yazi',
      mode = { 'n', 'v' },
    },
    {
      '<leader>Z',
      '<cmd>Yazi cwd<cr>',
      desc = '在Neovim工作目录打开yazi',
    },
    {
      '<leader>tz',
      '<cmd>Yazi toggle<cr>',
      desc = '切换上一个yazi会话',
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
