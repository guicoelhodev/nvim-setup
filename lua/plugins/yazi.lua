vim.pack.add({
	{ src = 'https://github.com/mikavilpas/yazi.nvim', version = '*' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
})

local yazi = require('yazi')

yazi.setup({
	open_for_directories = false,
	keymaps = {
		show_help = "<f1>",
	},
})

-- Keymaps
vim.keymap.set('n', 'fj', '<CMD>Yazi<CR>', { desc = 'Open yazi at the current file' })
vim.keymap.set('n', 'fa', '<CMD>Yazi cwd<CR>', { desc = 'Open yazi in current working directory' })
