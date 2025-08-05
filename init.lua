require('config.options')
require('config.lsp')
require('config.keymap')












-- load all files into lua/plugins/*.lua

local cfg = vim.fn.stdpath("config")
local plugin_folder = cfg .. "/lua/plugins"

local files = vim.fn.readdir(plugin_folder, [[v:val =~ '\.lua$']])
for _, fname in ipairs(files) do
	local mod = "plugins." .. fname:gsub("%.lua$", "")
	local ok, _ = pcall(require, mod)
	if not ok then
		vim.notify("Error to run: " .. mod, vim.log.levels.ERROR)
	end
end
