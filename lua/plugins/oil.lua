return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			default_file_explorer = false,
			delete_to_trash = true,
			float = {
				max_width = 0.8,
				preview_split = "right",
			},
			keymaps = {
				["h"] = { "actions.parent", mode = "n" },
				["l"] = { "actions.select", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
			},
		},
		keys = {
			{
				"fj",
				function()
					require("oil").open_float(nil, { preview = {} })
				end,
				desc = "File explorer (current file)",
			},
			{
				"fa",
				function()
					require("oil").open_float(vim.fn.getcwd(), { preview = {} })
				end,
				desc = "File explorer (working directory)",
			},
		},
	},
}
