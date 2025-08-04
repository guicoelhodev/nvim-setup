vim.pack.add({
	{ src = "https://github.com/norcalli/nvim-terminal.lua" },
	{ src = "https://github.com/camgraff/telescope-tmux.nvim" },
})

local telescope = require("telescope")
telescope.load_extension("tmux")

vim.keymap.set("n", "<C-i>", ":Telescope tmux sessions<CR>")
