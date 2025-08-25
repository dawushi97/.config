return {
  {
    'aserowy/tmux.nvim',
    -- 只在检测到tmux环境时加载插件
    cond = function()
      return vim.env.TMUX ~= nil
    end,
    config = function()
      require('tmux').setup {
        -- 复制模式
        copy_sync = {
          enable = false,
          sync_clipboard = true,
          sync_registers = true,
          sync_deletes = true,
          sync_unnamed = true,
        },
        -- 导航
        navigation = {
          enable_default_keybindings = true, -- 在tmux环境中使用插件的默认键位
          cycle_navigation = true,
          persist_zoom = false,
        },
        -- 调整窗格大小
        resize = {
          enable_default_keybindings = true,
          resize_step_x = 5,
          resize_step_y = 5,
        },
      }
    end,
  },
}
