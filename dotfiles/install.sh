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

# 同步 Claude Code 配置（使用复制而非软链接，避免兼容性问题）
CLAUDE_SRC="$DOTFILES_DIR/../claude"
CLAUDE_DST="$HOME/.claude"
if [ -d "$CLAUDE_SRC" ]; then
    echo
    echo "同步 Claude Code 配置..."
    mkdir -p "$CLAUDE_DST/commands" "$CLAUDE_DST/sounds"
    for f in settings.json keybindings.json CLAUDE.md; do
        if [ -f "$CLAUDE_SRC/$f" ]; then
            echo "复制: $f -> $CLAUDE_DST/$f"
            cp "$CLAUDE_SRC/$f" "$CLAUDE_DST/$f"
        fi
    done
    cp -r "$CLAUDE_SRC/commands/"* "$CLAUDE_DST/commands/" 2>/dev/null
    cp -r "$CLAUDE_SRC/sounds/"* "$CLAUDE_DST/sounds/" 2>/dev/null
fi

echo
echo "Dotfiles 安装完成！"
echo "请重新启动终端或运行 'source ~/.zshrc' 来应用配置。"
