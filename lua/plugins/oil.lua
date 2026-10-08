local filter = ""

local function set_filter(value)
	if vim.bo.modified then
		vim.notify("Save or discard changes before filtering", vim.log.levels.WARN)
		return
	end
	filter = value or ""
	require("oil.view").rerender_all_oil_buffers({ refetch = false })
	vim.notify(filter == "" and "Filter cleared" or ("Filter: " .. filter))
end

return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			default_file_explorer = false,
			delete_to_trash = true,
			view_options = {
				is_always_hidden = function(name)
					if filter == "" or name == ".." then
						return false
					end
					return not name:lower():find(filter:lower(), 1, true)
				end,
			},
			float = {
				max_width = 0.8,
				preview_split = "right",
			},
			keymaps = {
				["h"] = { "actions.parent", mode = "n" },
				["l"] = { "actions.select", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
				["f"] = {
					desc = "Filter entries by name",
					mode = "n",
					nowait = true,
					callback = function()
						vim.ui.input({ prompt = "Filter: ", default = filter }, function(input)
							if input ~= nil then
								set_filter(input)
							end
						end)
					end,
				},
				["g\\"] = {
					desc = "Clear filter",
					mode = "n",
					callback = function()
						set_filter("")
					end,
				},
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
						local path = "@" .. vim.fn.fnamemodify(dir .. entry.name, ":.")
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
