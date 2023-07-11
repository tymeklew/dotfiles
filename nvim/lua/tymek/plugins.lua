local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'nvim-lua/plenary.nvim'
Plug 'neanias/everforest-nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'saecki/crates.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'github/copilot.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'navarasu/onedark.nvim'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'mattn/emmet-vim'
Plug 'nvim-lualine/lualine.nvim'
Plug('catppuccin/nvim', { as = "catppuccin" })
vim.call('plug#end')


require 'crates'.setup {}
require("luasnip.loaders.from_vscode").lazy_load()

require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "html", "css" },
	highlight = {
		enable = true
	}
}
