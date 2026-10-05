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
				["cc"] = {
					desc = "Copy relative path",
					mode = "n",
					callback = function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						local dir = oil.get_current_dir()
						if not entry or not dir then
							return
						end
						local path = vim.fn.fnamemodify(dir .. entry.name, ":.")
						vim.fn.setreg("+", path)
						vim.notify("Copied: " .. path)
					end,
				},
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
