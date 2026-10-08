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

local function close_oil()
	local oil = require("oil")
	for _, bufnr in ipairs(require("oil.view").get_all_buffers()) do
		if vim.bo[bufnr].modified then
			local winid = vim.api.nvim_get_current_win()
			local oil_bufnr = vim.api.nvim_get_current_buf()
			local function finish_close(err)
				if err then
					vim.notify(err, vim.log.levels.ERROR)
					return
				end
				if vim.api.nvim_win_is_valid(winid) and vim.api.nvim_win_get_buf(winid) == oil_bufnr then
					vim.api.nvim_win_call(winid, oil.close)
				end
			end
			oil.save({ confirm = true }, function(err)
				if err == "Canceled" then
					require("oil.view").rerender_all_oil_buffers(nil, finish_close)
				else
					finish_close(err)
				end
			end)
			return
		end
	end
	oil.close()
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
				["q"] = {
					desc = "Confirm or discard changes and close Oil",
					mode = "n",
					callback = close_oil,
				},
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
