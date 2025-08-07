local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set('n', '<leader>e', ':Ex <CR>')
keymap.set('n', '<C-u>', ':so <CR>')

keymap.set("i", "jj", "<ESC>", opts)
keymap.set("n", "<leader>x", ":bd<CR>", opts)
keymap.set("n", "<Space>x", ":bd<CR>", opts)
keymap.set("x", "P", '"_dP')
keymap.set("n", "C", "ciw")
keymap.set("n", "T", ":%s/\\C")

keymap.set("n", "S", ":w<CR>")
