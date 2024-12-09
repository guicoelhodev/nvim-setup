return {
	"nvimtools/none-ls.nvim",
	dependencies = {
    "nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local keymap = vim.keymap

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
        require("none-ls.diagnostics.eslint") -- requires none-ls-extras.nvim
			},
		})

		keymap.set("n", "fm", vim.lsp.buf.format, {})
		keymap.set("n", "S", function ()
			vim.lsp.buf.format();
			vim.cmd('write')
		end, {})
	end,
}
