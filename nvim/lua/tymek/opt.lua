require('onedark').setup {
	transparent = true
}

vim.opt.shiftwidth = 3
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.expandtab = false
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.o.wildmode = 'longest,list,full'
vim.o.wildmenu = true
vim.cmd.colorscheme "onedark"
vim.opt.clipboard = "unnamedplus"
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
