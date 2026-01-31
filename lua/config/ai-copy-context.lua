local M = {}

function M.send_to_claude()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.fn.getline(start_pos[2], end_pos[2])

	if #lines == 0 then
		vim.notify("No selection found", vim.log.levels.WARN)
		return
	end

	local filepath = vim.fn.expand("%")
	local filename = vim.fn.expand("%:t")

	local line_ref
	if start_pos[2] == end_pos[2] then
		line_ref = string.format("#L%d", start_pos[2])
	else
		line_ref = string.format("#L%d-%d", start_pos[2], end_pos[2])
	end

	local formatted = string.format("@%s%s", filepath, line_ref)
	local display_ref = string.format("@%s%s", filename, line_ref)

	vim.fn.setreg("+", formatted)
	vim.fn.setreg("*", formatted)

	vim.notify("Reference copied: " .. display_ref, vim.log.levels.INFO)
end

return M
