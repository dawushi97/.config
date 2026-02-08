# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Architecture

This is a Neovim configuration based on kickstart.nvim with modular customizations. The configuration follows a structured approach:

### Core Structure
- `init.lua` - Entry point that loads core modules
- `lua/core/` - Core configuration modules:
  - `options.lua` - Vim options and settings (2-space tabs, auto-save on buffer leave)
  - `keymaps.lua` - Basic keymaps and autocommands (TMUX-aware window navigation)
  - `lazy-bootstrap.lua` - Lazy.nvim plugin manager bootstrap
  - `lazy-plugins.lua` - Plugin specifications and setup

### Plugin Organization
- `lua/kickstart/plugins/` - Standard kickstart plugins (LSP, telescope, treesitter, etc.)
- `lua/custom/plugins/` - Custom plugin configurations:
  - Individual plugin files (toggleterm, gruvbox, snacks, etc.)
  - `init.lua` - Empty placeholder for additional plugins
- `after/ftplugin/` - Filetype-specific configurations (mostly empty)

### Language Support
- `lsp/` directory contains language-specific LSP configurations:
  - `init.lua` - LSP initialization (currently empty)
  - `handlers.lua` - Custom LSP handlers
  - `languages/` - Per-language LSP setup (cpp, go, lua, python, rust, typescript)

## Key Configuration Details

### Plugin Manager
Uses lazy.nvim with plugins loaded from both kickstart and custom directories. Notable plugins:
- Language servers via mason.nvim/lspconfig
- File explorer via neo-tree
- Terminal integration via toggleterm
- Theme: gruvbox (tokyonight commented out)
- Enhanced UI via noice.nvim and snacks.nvim

### Development Settings
- 2-space indentation across all file types
- Auto-save on buffer leave
- Relative line numbers enabled
- Nerd font support enabled (`vim.g.have_nerd_font = true`)
- Clipboard integration with system clipboard

### TMUX Integration
Window navigation keymaps are conditionally disabled when running inside TMUX (handled in `core/keymaps.lua`).

## Working with This Configuration

### Adding New Plugins
Add plugin specifications to `lua/core/lazy-plugins.lua` or create new files in `lua/custom/plugins/`.

### Language-Specific Configuration
Add filetype settings in `after/ftplugin/` or LSP configurations in `lsp/languages/`.

### Testing Changes
After making configuration changes, restart Neovim or use `:source %` to reload current file. Use `:Lazy` to manage plugin installations.

### Plugin Dependencies
Check `lazy-lock.json` for exact plugin versions. This file should be tracked in version control for reproducible setups.