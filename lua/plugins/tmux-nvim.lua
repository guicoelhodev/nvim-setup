return {
  "camgraff/telescope-tmux.nvim",
  requires = { "nvim-telescope/telescope.nvim", "nvim-terminal.lua" },
  config = function()
    require("telescope").setup({
      extensions = {
        tmux = {
          -- configurações adicionais, se quiser
        },
      },
    })
    require("telescope").load_extension("tmux")
  end,
}
