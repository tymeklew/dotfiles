vim.opt.shiftwidth = 3
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
vim.opt.swapfile = false
vim.wo.number = true
vim.opt.number = true
vim.opt.relativenumber = true

require('packer').startup(function(use)
   use 'wbthomason/packer.nvim'
   use 'nvim-treesitter/nvim-treesitter'
   use 'VonHeikemen/lsp-zero.nvim'
   use 'williamboman/mason.nvim'
   use 'williamboman/mason-lspconfig.nvim'
   use 'neovim/nvim-lspconfig'
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/nvim-cmp'
   use 'L3MON4D3/LuaSnip'
   use "folke/trouble.nvim"
   use 'github/copilot.vim'
   use "nvim-tree/nvim-web-devicons"
   use 'saecki/crates.nvim'
   use { "catppuccin/nvim", as = "catppuccin" }
   use 'Bekaboo/dropbar.nvim'
   use {
      'nvim-telescope/telescope.nvim', tag = '0.1.4',
      -- or                            , branch = '0.1.x',
      requires = { { 'nvim-lua/plenary.nvim' } }
   }
end)

require('crates').setup {
   src = {
      cmp = {
         enabled = true,
      },
   },
}


require 'nvim-treesitter.configs'.setup {
   ensure_installed = { "c", "lua", "rust", "html", "c_sharp", "css", "python", "javascript", "typescript" },
   sync_install = false,
   auto_install = true,
   highlight = {
      enable = true,
   }
}
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
   lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
   ensure_installed = { 'tsserver', 'rust_analyzer', 'clangd', 'csharp_ls', 'lua_ls', 'gopls' },
   handlers = {
      lsp_zero.default_setup,
   }
})
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

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



local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<space>d', "<cmd>lua vim.lsp.buf.hover()<cr>", {})
vim.keymap.set('n', '<space>e', "<cmd>Ex<cr>", {});
vim.api.nvim_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>c', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>q',
   '<cmd>lua require("telescope.builtin").lsp_document_symbols({ symbols = { "Function", "Struct" } })<CR>',
   { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>g',
   '<cmd>lua require("telescope.builtin").lsp_workspace_symbols({ symbols = { "Function" , "Struct"} })<CR>',
   { noremap = true, silent = true })
vim.keymap.set("n", "<space>x", function() require("trouble").toggle() end)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics, {
      -- delay update diagnostics
      update_in_insert = true,
   }
)
require("catppuccin").setup({
   flavour = "mocha"
})
vim.cmd.colorscheme "catppuccin"
