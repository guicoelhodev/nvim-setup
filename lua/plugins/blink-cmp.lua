vim.pack.add({
	{ src = 'https://github.com/Saghen/blink.cmp',     version = '1.*' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
})

local blink = require("blink.cmp")

blink.setup({
	fuzzy = { implementation = 'lua' },
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = false },
		ghost_text = { enabled = false },
		commit_character_behavior = 'auto',
		accept = {}
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	keymap = {
		['<Tab>'] = { function(cmp) cmp.accept({ index = 1 }) end },
		['<C-h>'] = { function(cmp) cmp.show_documentation() end },
	}
})

local lspconfig = require("lspconfig")
lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
	"force",
	lspconfig.util.default_config.capabilities or vim.lsp.protocol.make_client_capabilities(),
	require("blink.cmp").get_lsp_capabilities()
)
