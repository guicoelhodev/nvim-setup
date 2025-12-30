return {
	{
		'stevearc/conform.nvim',
		config = function()
			require('conform').setup({
				formatters_by_ft = {
					javascript = { 'prettier' },
					typescript = { 'prettier' },
					javascriptreact = { 'prettier' },
					typescriptreact = { 'prettier' },
					css = { 'prettier' },
					html = { 'prettier' },
					json = { 'prettier' },
					yaml = { 'prettier' },
					markdown = { 'prettier' },
					lua = { 'stylua' },
				}
			})
		end,
	},
}
