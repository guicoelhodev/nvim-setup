-- Load options first
require("config.options")

-- Bootstrap and setup lazy.nvim
require("config.lazy")

-- Load LSP and keymaps
require("config.lsp")
require("config.keymap")

-- This prevent ts_ls and angular_ls access the same typescript file
local angular_markers = vim.fs.find({ "angular.json", "nx.json" }, { upward = true })

if #angular_markers > 0 then
	vim.lsp.config("ts_ls", { autostart = false })
end
