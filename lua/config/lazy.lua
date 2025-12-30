-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Import all plugins from lua/plugins/*.lua
		{ import = "plugins" },
	},
	install = {
		-- Install missing plugins on startup
		missing = true,
		colorscheme = { "tokyonight-night" },
	},
	checker = {
		-- Automatically check for plugin updates
		enabled = false,
		notify = false,
	},
	change_detection = {
		-- Automatically check for config file changes and reload the ui
		enabled = true,
		notify = false,
	},
	performance = {
		rtp = {
			-- Disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
