vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},
})

local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	ensure_installed = {},
	sync_install = false,
	auto_install = true,
	ignore_install = {},
	modules = {},
	highlight = {
		enable = true,
	},

	indent = {
		enable = true,
	},
})
