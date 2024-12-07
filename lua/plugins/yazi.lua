return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
  config = function()
    local keymap = vim.keymap

    keymap.set('n', 'fj', '<CMD>Yazi<CR>')
    keymap.set('n', 'fa', '<CMD>Yazi cwd<CR>')
  end
}
