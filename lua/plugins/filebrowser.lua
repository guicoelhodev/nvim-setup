vim.pack.add({
	{ src = 'https://github.com/mikavilpas/yazi.nvim' }
})

vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope-file-browser.nvim"}
})

vim.keymap.set("n", "fa", function ()
	require('telescope').extensions.file_browser.file_browser({
		initial_mode = "normal"
	})
end)


vim.keymap.set("n", "fj", function ()
	require('telescope').extensions.file_browser.file_browser({
		initial_mode = "normal",
		select_buffer = true,
		path = "%:p:h",
		hidden = true
	})
end)

