return {
	{
		'f-person/git-blame.nvim',
		keys = {
			{ "gb", ":GitBlameToggle<CR>", desc = "Toggle git blame" },
		},
		config = function()
			vim.g.gitblame_enabled = 0
		end,
	},
}
