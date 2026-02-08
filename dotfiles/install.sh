#!/bin/bash

# 获取 dotfiles 目录的绝对路径
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "开始安装 dotfiles..."
echo "Dotfiles 目录: $DOTFILES_DIR"
echo

# 创建符号链接的函数
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -f "$source" ]; then
        echo "创建链接: $target -> $source"
        ln -sf "$source" "$target"
    else
        echo "警告: 源文件不存在: $source"
    fi
}

# 创建配置文件的符号链接
create_symlink "$DOTFILES_DIR/.zshrc" ~/.zshrc
create_symlink "$DOTFILES_DIR/.vimrc" ~/.vimrc
create_symlink "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
create_symlink "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
create_symlink "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

echo
echo "Dotfiles 安装完成！"
echo "请重新启动终端或运行 'source ~/.zshrc' 来应用配置。"
