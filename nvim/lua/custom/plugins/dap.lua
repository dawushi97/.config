-- ~/.config/nvim/lua/kickstart/plugins/dap.lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',
    'nvim-neotest/nvim-nio', -- 添加缺少的依赖
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local keymap = vim.keymap.set

    -- 设置UI
    dapui.setup {
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          size = 40,
          position = 'left',
        },
        {
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          size = 10,
          position = 'bottom',
        },
      },
    }

    -- 配置CodeLLDB适配器
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- 以下路径需要根据你安装的实际路径调整
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
      },
    }

    -- C++配置
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          local args_str = vim.fn.input 'Arguments: '
          return vim.split(args_str, ' ')
        end,
        runInTerminal = false,
      },
      {
        name = 'Attach to process',
        type = 'codelldb',
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
      },
    }

    -- 同时适用于C语言
    dap.configurations.c = dap.configurations.cpp

    -- 为了方便起见，当UI打开/关闭时自动开始/结束调试会话
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- 虚拟文本设置
    require('nvim-dap-virtual-text').setup {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      virt_text_pos = 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    }

    -- 调试快捷键设置
    keymap('n', '<leader>dt', dap.toggle_breakpoint, { desc = '[D]ebug [T]oggle Breakpoint' })
    keymap('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
    keymap('n', '<leader>dn', dap.step_over, { desc = '[D]ebug Step [N]ext' })
    keymap('n', '<leader>di', dap.step_into, { desc = '[D]ebug Step [I]nto' })
    keymap('n', '<leader>do', dap.step_out, { desc = '[D]ebug Step [O]ut' })
    keymap('n', '<leader>dq', dap.terminate, { desc = '[D]ebug [Q]uit' })
    keymap('n', '<leader>dr', dap.restart, { desc = '[D]ebug [R]estart' })
    keymap('n', '<leader>dl', dap.run_last, { desc = '[D]ebug Run [L]ast' })
    keymap('n', '<leader>dh', dapui.eval, { desc = '[D]ebug [H]over Eval' })
    keymap('n', '<leader>du', function()
      dapui.toggle()
    end, { desc = '[D]ebug Toggle [U]I' })
    keymap('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[D]ebug Set Conditional [B]reakpoint' })
    keymap('n', '<leader>dp', function()
      dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end, { desc = '[D]ebug Set Log [P]oint' })

    -- 使用Telescope集成
    pcall(function()
      require('telescope').load_extension 'dap'
      keymap('n', '<leader>dC', '<cmd>Telescope dap commands<CR>', { desc = '[D]ebug [C]ommands' })
      keymap('n', '<leader>db', '<cmd>Telescope dap list_breakpoints<CR>', { desc = '[D]ebug List [B]reakpoints' })
      keymap('n', '<leader>dv', '<cmd>Telescope dap variables<CR>', { desc = '[D]ebug [V]ariables' })
      keymap('n', '<leader>df', '<cmd>Telescope dap frames<CR>', { desc = '[D]ebug [F]rames' })
    end)
  end,
}
