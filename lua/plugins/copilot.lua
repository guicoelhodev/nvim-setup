return {
	{
		'zbirenbaum/copilot.lua',
		dependencies = {
			'copilotlsp-nvim/copilot-lsp',
		},
		config = function()
			require('copilot').setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>"
					},
					layout = {
						position = "bottom",
						ratio = 0.4
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<Tab>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = true,
					markdown = true,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = 'node',
				server_opts_overrides = {},
			})

			vim.keymap.set('n', '<leader>cf', '<cmd>Copilot enable<CR>', { desc = 'Copilot Enable' })
			vim.keymap.set('n', '<leader>cd', '<cmd>Copilot disable<CR>', { desc = 'Copilot Disable' })
		end,
	},
}
