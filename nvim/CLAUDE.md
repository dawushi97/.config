# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Critical Rules

- **NEVER modify `init2.lua`** - This is the kickstart.nvim reference configuration and must remain unchanged

## Configuration Architecture

This is a Neovim configuration based on kickstart.nvim with modular customizations.

### Loading Order
1. `init.lua` sets leader key (space) and Nerd font flag, then loads:
   - `lua/core/options.lua` - Vim settings (2-space tabs, auto-save on BufLeave, relative line numbers)
   - `lua/core/keymaps.lua` - Basic keymaps with TMUX-aware window navigation
   - `lua/core/lazy-bootstrap.lua` - Installs lazy.nvim if missing
   - `lua/core/lazy-plugins.lua` - Central plugin registry

### Plugin Sources
- `lua/kickstart/plugins/` - Standard plugins (LSP, telescope, treesitter, completion via blink.cmp)
- `lua/custom/plugins/` - Custom plugins (toggleterm, gruvbox, snacks, yazi, cpp-tools, etc.)
- `after/ftplugin/` - Filetype-specific settings (cpp.lua has treesitter-cpp-tools keymaps)

### LSP Architecture
Main config in `lua/kickstart/plugins/lspconfig.lua` with Mason for auto-installation. Per-language overrides go in `lsp/languages/` (currently only cpp.lua has custom clangd settings).

Active servers: clangd (C++), gopls (Go), lua_ls (Lua)

## Key Keymaps

### LSP (when attached)
- `gd` - Goto definition, `gr` - Goto references, `gI` - Goto implementation
- `gD` - Goto declaration (header in C)
- `<leader>rn` - Rename, `<leader>ca` - Code action
- `<leader>ds` - Document symbols, `<leader>ws` - Workspace symbols
- `<leader>th` - Toggle inlay hints

### Terminal (toggleterm)
- `<C-\>` - Toggle terminal
- `<leader>tt/tv/tf` - Terminal horizontal/vertical/float
- `<leader>tr` - Compile and run C++ file (g++ -std=c++17)
- `<leader>tg` - Run Go (auto-detects go.mod projects)

### C++ (after/ftplugin/cpp.lua)
- `<leader>tdc` - Define class member functions (treesitter-cpp-tools)
- `<leader>tr3` - Add Rule of 3 functions
- `<leader>tr5` - Add Rule of 5 functions

### File Management
- `<leader>y` - Open Yazi at current file
- `<leader>Y` - Open Yazi at CWD

## Working with This Configuration

### Adding Plugins
Create a file in `lua/custom/plugins/newplugin.lua` returning a lazy.nvim spec table.

### Adding LSP Servers
1. Add server name to `servers` table in `lua/kickstart/plugins/lspconfig.lua`
2. Optionally add detailed config in `lsp/languages/servername.lua`

### Testing Changes
Restart Neovim or `:source %` for current file. Use `:Lazy` for plugin management, `:Mason` for LSP servers.