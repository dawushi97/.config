-- 插件特定快捷键选项
local opts = { noremap = true, silent = true, buffer = 0 }

-- nvim-treesitter-cpp-tools 快捷键配置
vim.keymap.set('n', '<Leader>tdc', '<cmd>TSCppDefineClassFunc<CR>', opts) -- 实现类的成员函数
vim.keymap.set('n', '<Leader>tr3', '<cmd>TSCppRuleOf3<CR>', opts) -- 添加遵循Rule of 3的函数声明
vim.keymap.set('n', '<Leader>tr5', '<cmd>TSCppRuleOf5<CR>', opts) -- 添加遵循Rule of 5的函数声明

-- 如果插件支持 Visual 模式下的操作，可以这样配置
vim.keymap.set('v', '<Leader>tdc', ':TSCppDefineClassFunc<CR>', opts)
vim.keymap.set('v', '<Leader>tcc', ':TSCppMakeConcreteClass<CR>', opts)

-- C++ LSP 性能优化设置
vim.opt_local.updatetime = 300 -- 减少更新频率提升性能
vim.b.lsp_timeout = 2000 -- LSP 超时设置

-- 诊断显示优化 - 减少冗长信息
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN }, -- 只显示警告及以上级别
    format = function(diagnostic)
      local message = diagnostic.message
      if string.len(message) > 50 then
        return string.sub(message, 1, 47) .. "..." -- 截断长消息
      end
      return message
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- 插入模式时不更新诊断，减少干扰
}, vim.api.nvim_get_current_buf())

-- C++ 特定的补全优化设置
-- blink.cmp的per_filetype配置已经在主配置中处理了cpp文件
-- 这里添加一些C++特定的触发和行为优化
vim.opt_local.iskeyword:append(":")  -- 将冒号加入关键字，支持::操作符
vim.opt_local.iskeyword:append("-")  -- 将减号加入关键字，支持->操作符
