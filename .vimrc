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
utocmd FileType gitcommit setlocal spell    " 启用拼写检查
autocmd FileType gitcommit setlocal textwidth=72  " 设置72字符换行
autocmd FileType gitcommit setlocal colorcolumn=50,72  " 显示50和72字符的竖线
autocmd FileType gitcommit setlocal spelllang=en_us  " 设置拼写检查语言

" 突出显示第一行（标题行）
autocmd FileType gitcommit syntax on
autocmd FileType gitcommit highlight gitcommitSummary ctermfg=blue guifg=blue
