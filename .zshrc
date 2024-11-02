# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting
    z
    zsh-vi-mode
    brew
)

source $ZSH/oh-my-zsh.sh

# FZF 增强配置 - 添加在这里
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
  --height 40% 
  --layout=reverse 
  --border 
  --preview 'bat --style=numbers --color=always --line-range :500 {}'
  --preview-window=right:60%
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort'
  --bind 'ctrl-u:preview-half-page-up'
  --bind 'ctrl-d:preview-half-page-down'
"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# 自定义 FZF 函数
function fzf-history-widget() {
  local selected
  selected=$(history -n 1 | fzf --tac --no-sort)
  BUFFER=$selected
  zle end-of-line
}

# vim-mode 配置
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
export ZVM_VI_EDITOR=nvim

# vim-mode 快捷键修复
function zvm_after_init() {
  bindkey '^R' fzf-history-widget
  bindkey '^T' fzf-file-widget
  bindkey '^[c' fzf-cd-widget
  bindkey '^A' beginning-of-line
  bindkey '^E' end-of-line
  bindkey '^K' kill-line
  bindkey '^U' kill-whole-line
}

alias python=python3

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/sbin:$PATH"

# Qt6 配置
export PATH="/opt/homebrew/Cellar/qt/6.7.2_1/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/Cellar/qt/6.7.2_1/lib"
export CPPFLAGS="-I/opt/homebrew/Cellar/qt/6.7.2_1/include"

# Qt5 配置
export PATH="/opt/homebrew/Cellar/qt@5/5.15.15/bin:$PATH"
export LDFLAGS="$LDFLAGS -L/opt/homebrew/Cellar/qt@5/5.15.15/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/Cellar/qt@5/5.15.15/include"xport CPPFLAGS="$CPPFLAGS -I/opt/homebrew/Cellar/qt@5/5.15.15/include"
