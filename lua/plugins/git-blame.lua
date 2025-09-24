vim.pack.add({
	{ src = 'https://github.com/f-person/git-blame.nvim'}
})

vim.g.gitblame_enabled = 0

vim.keymap.set("n", "gb", ":GitBlameToggle<CR>", { desc = "Toggle git blame" })
