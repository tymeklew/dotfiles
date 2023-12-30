vim.wo.number = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.shell = 'fish'

-- Plugin setup
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use { "catppuccin/nvim", as = "catppuccin" }
	use 'nvim-treesitter/nvim-treesitter'
	use 'VonHeikemen/lsp-zero.nvim'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use 'simrat39/rust-tools.nvim'
	use 'folke/todo-comments.nvim'
end)

-- Theme setup
require("catppuccin").setup({
	flavour = "macchiato",
	transparent_background = true,
});

vim.cmd.colorscheme "catppuccin"

-- Tree sitter setup
require('nvim-treesitter.configs').setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "rust", "typescript", "go" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	highlight = {
		enable = true,
	}
}

-- Lsp setup
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		lsp_zero.default_setup,
	}
})


local cmp = require('cmp')

cmp.setup({
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = "crates" },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<Cr>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	}),
})

-- Some keybindings
vim.keymap.set('n', '<space>d', '<cmd>lua vim.lsp.buf.hover()<cr>')
vim.keymap.set('n', '<space>c', '<cmd>lua vim.lsp.buf.definition()<cr>')
vim.keymap.set('n', '<space>e', '<cmd> Explore <cr>')


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>f', builtin.find_files, {})
vim.keymap.set('n', '<space>r', builtin.live_grep, {})
vim.api.nvim_set_keymap('n', '<space>q',
	'<cmd>lua require("telescope.builtin").lsp_document_symbols({ symbols = { "Function", "Struct" } })<CR>',
	{ noremap = true, silent = true })

-- Clipboard
--

-- Rust tools
local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
})

require('todo-comments').setup({})
