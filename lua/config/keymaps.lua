local opts = { noremap = true, silent = true }
local keymap = vim.keymap

-- keymaps

-- enter on NORMAL mode
keymap.set("i", "jj", "<ESC>", opts)

-- replace content lke Ctrl + f vscode
keymap.set("n", "T", ":%s/\\C")

--- delete word and enter on insert mode
keymap.set("n", "C", "ciw")

-- close current buffer (file)
vim.api.nvim_set_keymap("n", "<Space>x", ":bd<CR>", opts)

-- lazy git
keymap.set("n", "<leader>g", ":LazyGit<CR>", opts)

-- move with selected block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv' '>+1<CR>gv=gv'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv' '<-2<CR>gv=gv' ")

-- format and save
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- vim.keymap.set("n", "S", "w<CR>")

-- copy without lose the current past buffer

vim.keymap.set("x", "P", '"_dP')

-- Open sessions with tmux and telescope

vim.keymap.set("n", "<C-i>", ":Telescope tmux sessions<CR>")
return {}
