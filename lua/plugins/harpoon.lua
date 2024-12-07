return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function ()
		local harpoon = require("harpoon")

		harpoon:setup()

		-- Register file
		vim.keymap.set("n", "wr", function() harpoon:list():add() end)

		-- List modal with registered files
		vim.keymap.set("n", "we", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		-- Navigate through files in the regiser
		vim.keymap.set("n", "wh", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "wj", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "wk", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "wl", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "wp", function() harpoon:list():prev() end)
		vim.keymap.set("n", "wn", function() harpoon:list():next() end)
	end
}
