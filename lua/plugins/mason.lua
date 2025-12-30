return {
	{
		'mason-org/mason.nvim',
		dependencies = {
			'neovim/nvim-lspconfig',
			'mason-org/mason-lspconfig.nvim',
		},
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"tailwindcss",
					"cssls",
					"html",
					"angularls",
					"gopls",
					"dockerls",
					"docker_compose_language_service",
					"dotls",
				},
				automatic_enable = true,
			})
		end,
	},
}
