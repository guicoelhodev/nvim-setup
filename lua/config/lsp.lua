local lsp = vim.lsp
local keymap = vim.keymap

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

keymap.set("n", "<C-p>", function() vim.diagnostic.jump({ count = 1, float = true }) end)
keymap.set("n", "<C-n>", function() vim.diagnostic.jump({ count = -1, float = true }) end)

keymap.set("n", "<C-s>", function()
	vim.lsp.buf.format()
	vim.cmd('write')
end
)

keymap.set("n", "gl", vim.diagnostic.open_float)
keymap.set("n", "gd", lsp.buf.definition)
keymap.set("n", "<C-k>", lsp.buf.signature_help)
keymap.set("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end)
