vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- delay update diagnostics
		update_in_insert = true,
	}
)

require('lspconfig')['clangd'].setup {
	cmd = { '/usr/bin/clangd' },
	flags = {
		debounce_text_changes = 150
	}
}

require("lsp-format").setup {}
require("lspconfig").gopls.setup { on_attach = require("lsp-format").on_attach }

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
local nvim_lsp = require('lspconfig')

function on_attach(client, bufnr)
	vim.keymap.set('n', 'k', '<cmd>lua vim.lsp.buf.definition()<cr>', { noremap = true, silent = true })
end

-- make a function to
