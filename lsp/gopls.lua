vim.lsp.config("gopls", {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
			gofumpt = true,
			usePlaceholders = true,
			completeUnimported = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})
