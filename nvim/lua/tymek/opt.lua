require('onedark').setup {
	transparent = true
}

vim.opt.shiftwidth = 3
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.o.wildmode = 'longest,list,full'
vim.o.wildmenu = true
vim.autoindent = true
vim.cmd.colorscheme "onedark"
vim.g.copilot_no_tab_map = true
vim.opt.clipboard = "unnamedplus"
vim.g.copilot_assume_mapped = true

vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
