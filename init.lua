vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
--[[Setting options]]
require 'core.options'

-- [[ Basic Keymaps ]]
require 'core.keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'core.lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'core.lazy-plugins'
