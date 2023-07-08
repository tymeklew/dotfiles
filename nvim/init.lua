vim.opt.shiftwidth = 3
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.o.wildmode = 'longest,list,full'
vim.o.wildmenu = true
vim.autoindent = true

local Plug = vim.fn['plug#']

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
vim.keymap.set('n', '<space>f', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<meta>s', '<cmd>write<cr>')
vim.keymap.set('n', "<space>k", "<cmd>lua vim.lsp.buf.definition()<cr>")
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
	opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

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
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'mattn/emmet-vim'
vim.call('plug#end')


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- delay update diagnostics
		update_in_insert = true,
	}
)

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require 'crates'.setup {}

lsp.setup()


vim.cmd [[colorscheme everforest]]


-- make it so nvim is transparent
vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]

vim.cmd [[ set completeopt=menuone,noinsert,noselect ]]

require('lspconfig')['clangd'].setup {
	cmd = { '/usr/bin/clangd' },
	flags = {
		debounce_text_changes = 150
	}
}

require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "html", "css" },
	highlight = {
		enable = true
	}
}




local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-o>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<TAB>'] = cmp.mapping.confirm({ select = true }),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	}),
})



require("luasnip.loaders.from_vscode").lazy_load()
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]


require("lsp-format").setup {}
require("lspconfig").gopls.setup { on_attach = require("lsp-format").on_attach }


vim.opt.clipboard = "unnamedplus"
