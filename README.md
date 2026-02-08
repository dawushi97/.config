# dotfiles

My macOS development environment configs. One script to set up terminal, editor, keybindings, and more.

## Install

```bash
git clone <repo-url> ~/.config
cd ~/.config/dotfiles && ./install.sh
source ~/.zshrc
```

`install.sh` symlinks dotfiles to `$HOME` and copies Claude Code config to `~/.claude/`.

## Stack

- **Shell**: Zsh + [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **Terminal**: [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Editor**: [Neovim](https://neovim.io/) (based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim))
- **Multiplexer**: [Tmux](https://github.com/tmux/tmux) (prefix `C-a`, vim-style navigation)
- **File Manager**: [Yazi](https://yazi-rs.github.io/)
- **AI Coding**: [Claude Code](https://claude.ai/code)

Neovim and Tmux share seamless `C-h/j/k/l` pane switching via [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator).

## Structure

```
├── dotfiles/              # Home directory configs (symlinked to ~)
│   ├── .zshrc             #   Zsh config
│   ├── .tmux.conf         #   Tmux config
│   ├── .vimrc             #   Vim baseline
│   ├── .gitconfig         #   Git user config
│   ├── .p10k.zsh          #   Powerlevel10k theme
│   └── install.sh         #   Install script
├── nvim/                  # Neovim config (Lua)
│   ├── init.lua           #   Entry point
│   ├── lsp/               #   LSP setup (C++/Go/Lua/Python/Rust/TS)
│   ├── lua/core/          #   Core settings (options, keymaps, lazy bootstrap)
│   ├── lua/kickstart/     #   Kickstart base plugins
│   └── lua/custom/        #   Custom plugins (gruvbox, DAP, snacks, etc.)
├── tmux/                  # Tmux scripts
│   └── scripts/           #   Status bar, session management, layouts
├── kitty/                 # Kitty terminal config + themes
├── yazi/                  # Yazi file manager + mactag plugin
├── claude/                # Claude Code config (copy of ~/.claude/)
│   ├── settings.json      #   Global settings
│   ├── keybindings.json   #   Keybindings
│   └── commands/          #   Custom skills
└── CLAUDE.md              # Claude Code project instructions
```

## Notes

- API keys live in `~/.env.secret` (not tracked)
- `claude/` is a copy of `~/.claude/` for git tracking — do not symlink `~/.claude/settings.json` ([known issue](https://github.com/anthropics/claude-code/issues/3575))
