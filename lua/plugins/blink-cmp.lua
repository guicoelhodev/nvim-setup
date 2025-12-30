return {
	{
		'Saghen/blink.cmp',
		version = '1.*',
		dependencies = {
			'neovim/nvim-lspconfig',
			'L3MON4D3/LuaSnip',
		},
		config = function()
			local blink = require("blink.cmp")

			blink.setup({
				fuzzy = {
					implementation = "rust",
					prebuilt_binaries = {
						force_version = "v1.8.0"
					}
				},
				signature = { enabled = true },
				snippets = { preset = "luasnip" },
				completion = {
					documentation = { auto_show = false },
					ghost_text = { enabled = false },
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				keymap = {
					['<Tab>'] = {
						function(cmp)
							if cmp.snippet_active() then
								return cmp.accept()
							else
								return cmp.select_and_accept()
							end
						end,
						'snippet_forward', 'fallback'
					},
					['<C-h>'] = { function(cmp) cmp.show_documentation() end },
				}
			})

			local lspconfig = require("lspconfig")
			lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig.util.default_config.capabilities or vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities()
			)
		end,
	},
}
