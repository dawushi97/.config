return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- 设置终端开启的方向和大小
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]], -- Ctrl+\ 打开关闭终端
      shade_terminals = true,
      direction = 'float', -- 默认浮动
      float_opts = {
        border = 'curved', -- 设置浮动窗口边框样式
        width = 100,
        height = 25,
        winblend = 3,
      },
    }

    -- 记录上一次使用的终端方向
    local last_direction = 'float' -- 默认为浮动模式

    -- 创建运行C++代码的函数
    local function compile_and_run_cpp()
      -- 使用完整路径
      local file = vim.fn.expand '%:p'
      local file_dir = vim.fn.expand '%:p:h' -- 获取文件所在目录
      local file_name = vim.fn.expand '%:t' -- 获取文件名
      local file_name_without_ext = vim.fn.expand '%:t:r' -- 不带扩展名的文件名

      -- 检查文件是否存在
      if vim.fn.filereadable(file) == 0 then
        vim.notify('File not found: ' .. file, vim.log.levels.ERROR)
        return
      end

      -- 创建新终端并执行命令，注意切换到正确的目录
      local Terminal = require('toggleterm.terminal').Terminal
      local runner = Terminal:new {
        -- 先cd到文件所在目录，然后编译运行
        cmd = string.format('cd %s && g++ -std=c++17 %s -o %s && ./%s', file_dir, file_name, file_name_without_ext, file_name_without_ext),
        direction = last_direction,
        close_on_exit = false,
        on_stderr = function(_, _, data)
          if data then
            print('Compilation Error:', vim.inspect(data))
          end
        end,
      }

      runner:toggle()
    end
    -- Function to detect if we're in a Go module project
    local function is_go_module()
      return vim.fn.findfile('go.mod', '.;') ~= ''
    end

    -- Function to find the main package directory in a Go module project
    local function find_main_package()
      local go_mod = vim.fn.findfile('go.mod', '.;')
      if go_mod == '' then
        return nil
      end

      local project_root = vim.fn.fnamemodify(go_mod, ':p:h')

      -- Search for main.go files in the cmd directory
      local cmd_dir = project_root .. '/cmd'
      if vim.fn.isdirectory(cmd_dir) == 1 then
        -- Look for directories under cmd/
        local sub_dirs = vim.fn.systemlist('ls -d ' .. vim.fn.shellescape(cmd_dir) .. '/*/')
        for _, dir in ipairs(sub_dirs) do
          local main_file = dir .. 'main.go'
          if vim.fn.filereadable(main_file) == 1 then
            -- Return relative path from project root to the cmd subdirectory
            return './cmd/' .. vim.fn.fnamemodify(dir, ':h:t')
          end
        end
      end

      return nil
    end

    -- Updated run_go function to handle both scenarios
    local function run_go()
      -- Get current file path
      local current_file = vim.fn.expand '%:p'
      local file_dir = vim.fn.expand '%:p:h'

      -- Check if we're in a Go module project
      if is_go_module() then
        local main_package = find_main_package()
        if main_package then
          -- Go module project: run the main package
          local Terminal = require('toggleterm.terminal').Terminal
          local cmd = string.format('cd %s && go run %s', vim.fn.shellescape(vim.fn.fnamemodify(vim.fn.findfile('go.mod', '.;'), ':p:h')), main_package)

          local runner = Terminal:new {
            cmd = cmd,
            direction = last_direction,
            close_on_exit = false,
            on_stderr = function(_, _, data)
              if data then
                print('Error:', vim.inspect(data))
              end
            end,
          }
          runner:toggle()
        else
          vim.notify('No main package found in cmd/* directory', vim.log.levels.ERROR)
        end
      else
        -- Single file: run the current file
        local Terminal = require('toggleterm.terminal').Terminal
        local cmd = string.format('cd %s && go run %s', vim.fn.shellescape(file_dir), vim.fn.shellescape(vim.fn.expand '%:t'))

        local runner = Terminal:new {
          cmd = cmd,
          direction = last_direction,
          close_on_exit = false,
          on_stderr = function(_, _, data)
            if data then
              print('Error:', vim.inspect(data))
            end
          end,
        }
        runner:toggle()
      end
    end

    -- Keep your existing keybinding
    vim.keymap.set('n', '<leader>tg', function()
      run_go()
    end, { desc = '[T]oggleterm Run [G]o' })
    -- 设置快捷键
    vim.keymap.set('n', '<leader>tr', function()
      compile_and_run_cpp() -- 使用上次运行的方向
    end, { desc = '[T]oggleterm [R]un C++' })

    vim.keymap.set('n', '<leader>tt', function()
      last_direction = 'horizontal' -- 设置为水平分布
      vim.cmd 'ToggleTerm direction=horizontal'
    end, { desc = '[T]oggleterm [T]oggle (Horizontal)' })

    vim.keymap.set('n', '<leader>tv', function()
      last_direction = 'vertical' -- 设置为垂直分布
      vim.cmd 'ToggleTerm direction=vertical'
    end, { desc = '[T]oggleterm [V]ertical' })

    vim.keymap.set('n', '<leader>tf', function()
      last_direction = 'float' -- 设置为浮动分布
      vim.cmd 'ToggleTerm direction=float'
    end, { desc = '[T]oggleterm [F]loat' })

    -- 在终端中使用 ESC 进入 normal 模式
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- 当打开终端时自动设置快捷键
    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
  end,
}
