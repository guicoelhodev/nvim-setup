return {
	{
		'L3MON4D3/LuaSnip',
		config = function()
			require('luasnip').setup({
				history = true,
				delete_check_events = "TextChanged",
			})
			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/lua/snippets" }
			})
		end,
	},
}
