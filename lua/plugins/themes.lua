return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	{
		"shrikecode/kyotonight.vim",
		lazy = false,
	},
	{
		"baliestri/aura-theme",
		lazy = false,
		priority = 1000,
		config = function(plugin)
			-- vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
			-- vim.cmd([[colorscheme aura-dark]])
		end,
	},
}
