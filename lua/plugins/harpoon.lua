vim.pack.add({
  { src      = "https://github.com/nvim-lua/plenary.nvim" },
  { src      = "https://github.com/ThePrimeagen/harpoon", version   = "harpoon2" },
})

local harpoon = require("harpoon")

local km = vim.keymap.set

km("n", "wr", function() harpoon:list():add() end, { desc = "Harpoon: adicionar arquivo" })
km("n", "we", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: abrir menu de arquivos" })
km("n", "wh", function() harpoon:list():select(1) end, { desc = "Harpoon: ir para arquivo 1" })
km("n", "wj", function() harpoon:list():select(2) end, { desc = "arquivo 2" })
km("n", "wk", function() harpoon:list():select(3) end, { desc = "arquivo 3" })
km("n", "wl", function() harpoon:list():select(4) end, { desc = "arquivo 4" })

km("n", "wp", function() harpoon:list():prev() end, { desc = "Harpoon: arquivo anterior" })
km("n", "wn", function() harpoon:list():next() end, { desc = "Harpoon: próximo arquivo" })
