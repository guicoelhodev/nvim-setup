local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>e', ':Ex <CR>')
vim.keymap.set('n', '<C-u>', ':so <CR>')


vim.keymap.set("i", "jj", "<ESC>", opts)
vim.api.nvim_set_keymap("n", "<leader>x", ":bd<CR>", opts)
