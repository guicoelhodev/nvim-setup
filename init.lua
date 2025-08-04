require('config.options')
require('config.lsp')
require('config.keymap')

vim.pack.add({
  	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
  	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/folke/tokyonight.nvim'}
})


vim.cmd[[colorscheme tokyonight-night]]

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { 'lua_ls', 'ts_ls' },
  automatic_enable = true,
})

