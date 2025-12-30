return {
	{
		'mikavilpas/yazi.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		keys = {
			{ 'fj', '<CMD>Yazi<CR>',     desc = 'Open yazi at the current file' },
			{ 'fa', '<CMD>Yazi cwd<CR>', desc = 'Open yazi in current working directory' },
		},
		config = function()
			require('yazi').setup({
				open_for_directories = false,
				keymaps = {
					show_help = "<f1>",
				},
			})
		end,
	},
}
