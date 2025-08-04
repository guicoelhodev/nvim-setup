vim.pack.add({
	{ src = 'https://github.com/mikavilpas/yazi.nvim' }
})

vim.keymap.set('n', 'fj', '<CMD>Yazi<CR>')
vim.keymap.set('n', 'fa', '<CMD>Yazi cwd<CR>')
