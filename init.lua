require('config.options')

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>e', ':Explore <CR>')
vim.keymap.set('n', '<C-u>', ':so<CR>')
vim.keymap.set('n', '<C-s>', ':w<CR>')

vim.pack.add({
	{ src = 'https://github.com/folke/tokyonight.nvim'},
  { src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' }
})

vim.cmd[[colorscheme tokyonight-night]]

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { 'lua_ls', 'ts_ls' },
  automatic_enable = true,
})

vim.opt.completeopt = { "menuone", "noselect", "noinsert", "popup" }
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if not client then
      return
    end
     -- nightly has inbuilt completions, this can replace all completion plugins
    if client:supports_method("textDocument/completion", bufnr) then
       -- Enable auto-completion
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
     end
  end,
})

vim.diagnostic.config({
    virtual_lines = false,
  	virtual_text = {
			spacing = 2,
			prefix = "●",
			source = false,
			severity = vim.diagnostic.severity.ERROR,
  	},
})


vim.keymap.set("n", "<C-p>", function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set("n", "<C-n>", function() vim.diagnostic.jump({ count =-1, float = true }) end)

