print('Hello new config')

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>e', ':Explore <CR>')
vim.keymap.set('n', '<C-u>', ':so<CR>')
vim.keymap.set('n', '<C-s>', ':w<CR>')

vim.pack.add({
	{ src = 'https://github.com/folke/tokyonight.nvim'}
})

vim.cmd[[colorscheme tokyonight-night]]
