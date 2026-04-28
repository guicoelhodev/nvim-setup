return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {},
	config = function()
		require("tree-sitter-manager").setup({
			ensure_installed = {
				"javascript",
				"typescript",
				"tsx",
				"jsx",
				"json",
				"html",
				"css",
				"scss",
				"svelte",
				"lua",
				"markdown",
				"yaml",
				"bash",
			},
			auto_install = true,
			highlight = true,
		})

		vim.treesitter.language.register("svelte", { "svelte" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "svelte" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
