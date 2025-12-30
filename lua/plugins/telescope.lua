return {
	{
		'nvim-telescope/telescope.nvim',
		version = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-ui-select.nvim',
		},
		config = function()
			local telescope = require('telescope')
			telescope.setup({
				defaults = {
					border = false,
					layout_config = {
						horizontal = {
							width = 0.95,
							preview_width = 0.6
						}
					}
				},
				extensions = {
					["ui-select"] = {
						require('telescope.themes').get_dropdown({})
					},
				},
			})
			telescope.load_extension('ui-select')

			local builtin = require('telescope.builtin')

			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles (Telescope)' })
			vim.keymap.set('n', 'fw', builtin.live_grep, { desc = '[F]ind by [G]rep (Telescope)' })

			vim.keymap.set('n', 'gd', function()
				builtin.lsp_definitions({
					initial_mode = "normal",
					reuse_win = true,
				})
			end, { desc = 'LSP: goto definition (Telescope)' })
		end,
	},
}
