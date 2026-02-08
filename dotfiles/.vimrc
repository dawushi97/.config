let mapleader = " "
set clipboard=unnamed

noremap <leader>w :wq<CR>
noremap <leader>q :q<CR>

syntax enable

set undofile                
set undodir=~/.vim/undodir  

set wildmenu
set showmatch
set hlsearch
set number
set backspace=2
set tabstop=4
set shiftwidth=4
set timeoutlen=1000 ttimeoutlen=0
set laststatus=2
set hidden

autocmd FileType gitcommit setlocal spell    " 启用拼写检查
autocmd FileType gitcommit setlocal textwidth=72  " 设置72字符换行
autocmd FileType gitcommit setlocal colorcolumn=50,72  " 显示50和72字符的竖线
autocmd FileType gitcommit setlocal spelllang=en_us  " 设置拼写检查语言

" 突出显示第一行（标题行）
autocmd FileType gitcommit syntax on
autocmd FileType gitcommit highlight gitcommitSummary ctermfg=blue guifg=blue
" 在不同模式下使用不同的光标样式
" 1 -> blinking block
" 2 -> solid block 
" 3 -> blinking underscore
" 4 -> solid underscore
" 5 -> blinking vertical bar
" 6 -> solid vertical bar

let &t_SI = "\e[6 q"  " INSERT 模式使用竖线光标
let &t_EI = "\e[2 q"  " NORMAL 模式使用方块光标
let &t_SR = "\e[4 q"  " REPLACE 模式使用下划线光标

" 确保vim启动时为方块光标
autocmd VimEnter * silent !echo -ne "\e[2 q"
" 确保退出时重置光标
autocmd VimLeave * silent !echo -ne "\e[6 q"
