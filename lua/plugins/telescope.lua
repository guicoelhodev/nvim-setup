vim.pack.add({
	{ src = 'nvim-lua/plenary.nvim' },
	{ src = 'nvim-telescope/telescope.nvim',          version = '0.1.8' }, -- tag opcional
	{ src = 'nvim-telescope/telescope-ui-select.nvim' },
})

local telescope = require('telescope')
telescope.setup({
	extensions = {
		["ui-select"] = {
			require('telescope.themes').get_dropdown({}) -- define o dropdown
		},
	},
})
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles (Telescope)' })
vim.keymap.set('n', 'fw', builtin.live_grep, { desc = '[F]ind by [G]rep (Telescope)' })
