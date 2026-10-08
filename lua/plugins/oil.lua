local filter = ""

local function can_filter()
	for _, bufnr in ipairs(require("oil.view").get_all_buffers()) do
		if vim.bo[bufnr].modified then
			vim.notify("Save or discard changes before filtering", vim.log.levels.WARN)
			return false
		end
	end
	return true
end

local function set_filter(value)
	filter = value or ""
	require("oil.view").rerender_all_oil_buffers({ refetch = false })
end

local function navigate(action)
	local had_filter = filter ~= ""
	if had_filter and not can_filter() then
		return
	end
	-- Clear the filter without moving the selected entry before Oil reads it.
	filter = ""
	require("oil.actions")[action].callback()
	if had_filter then
		require("oil.view").rerender_all_oil_buffers({ refetch = false })
	end
end

local function open_filter()
	if not can_filter() then
		return
	end
	local previous_filter = filter
	local active = true
	local autocmd = vim.api.nvim_create_autocmd("CmdlineChanged", {
		pattern = "@",
		callback = function()
			local value = vim.fn.getcmdline()
			vim.schedule(function()
				if active then
					set_filter(value)
					vim.cmd.redraw()
				end
			end)
		end,
	})
	local cancelled = "\001"
	local ok, value = pcall(vim.fn.input, {
		prompt = "Filter: ",
		default = previous_filter,
		cancelreturn = cancelled,
	})
	active = false
	vim.api.nvim_del_autocmd(autocmd)
	set_filter(ok and value ~= cancelled and value or previous_filter)
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
				["h"] = {
					desc = "Go to parent and clear filter",
					mode = "n",
					callback = function()
						navigate("parent")
					end,
				},
				["l"] = {
					desc = "Open entry and clear filter",
					mode = "n",
					callback = function()
						navigate("select")
					end,
				},
				["q"] = { "actions.close", mode = "n" },
				["f"] = {
					desc = "Filter entries by name",
					mode = "n",
					nowait = true,
					callback = open_filter,
				},
				["g\\"] = {
					desc = "Clear filter",
					mode = "n",
					callback = function()
						if can_filter() then
							set_filter("")
						end
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
