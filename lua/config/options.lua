vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.winborder = "rounded"
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 0
vim.o.backupcopy = "yes"
vim.opt.cmdheight = 1
vim.opt.linebreak = true
vim.opt.showcmd = true

vim.opt.ruler = true
vim.opt.laststatus = 0
-- vim.opt.completeopt = { "menuone", "noselect", "noinsert", "popup" }

vim.cmd(":hi statusline guibg=NONE")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
