require('config.options')

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>e', ':Explore <CR>')
vim.keymap.set('n', '<C-u>', ':so<CR>')
vim.keymap.set('n', '<C-s>', ':w<CR>')

vim.pack.add({
	{ src = 'https://github.com/folke/tokyonight.nvim'},
  { src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' }
})

vim.cmd[[colorscheme tokyonight-night]]

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { 'lua_ls', 'ts_ls' },
  automatic_enable = true,
})

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})
--vim.lsp.enable('lua_ls')

