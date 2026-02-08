return {
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', -- 推荐使用，因为每个新版本可能有破坏性变更
    opts = {
      bs = {
        enable = false, -- 禁用 backspace 删除配对，只删除单个字符
      },
    },
  },
}
