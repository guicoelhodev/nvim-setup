require("mason-lspconfig").setup({
	ensure_installed = { 'lua_ls', 'ts_ls' },
	automatic_enable = true,
})
