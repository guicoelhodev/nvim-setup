vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- map("n", "gd", vim.lsp.buf.definition, "LSP: goto definition")
		map("n", "gl", vim.diagnostic.open_float, "LSP: show diagnostic")
		map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: signature help")
		map("n", "K", function()
			local width = math.floor(vim.o.columns * 0.8)
			vim.lsp.buf.hover({ border = "single", max_height = 30, max_width = width })
		end, "LSP: hover doc")
		map("n", "<C-s>", function()
			vim.lsp.buf.format()
			vim.cmd("write")
		end, "LSP: format and save")
	map("n", "<C-p>", function() vim.diagnostic.jump({ count = 1, float = true }) end, "LSP: next diagnostic")
	map("n", "<C-n>", function() vim.diagnostic.jump({ count = -1, float = true }) end, "LSP: previous diagnostic")
	end,
})

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = {
		spacing = 2,
		prefix = "●",
		source = false,
		severity = vim.diagnostic.severity.ERROR,
	},
	float = {
		max_width = math.floor(vim.o.columns * 0.8),
		max_height = math.floor(vim.o.lines * 0.8),
	},
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lspinfo", -- If your LSP results are displayed in a specific window type
  callback = function()
    vim.keymap.set("n", "e", "<CR>:q<CR>", { buffer = true, silent = true })
  end,
})
