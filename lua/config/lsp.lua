vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		local function has_lsp_client(name)
			return #vim.lsp.get_clients({ bufnr = bufnr, name = name }) > 0
		end

		local function code_action(kind, client_name)
			local params = vim.lsp.util.make_range_params(0, "utf-16")
			params.context = {
				only = { kind },
				diagnostics = {},
			}

			local responses = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000) or {}
			for client_id, response in pairs(responses) do
				local client = vim.lsp.get_client_by_id(client_id)
				if client and (not client_name or client.name == client_name) and response.result then
					for _, action in ipairs(response.result) do
						if action.edit then
							vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding or "utf-16")
						end

						local command = nil
						if type(action.command) == "table" then
							command = action.command
						elseif type(action.command) == "string" or not action.edit then
							command = action
						end

						if command then
							pcall(function()
								client:exec_cmd(command, { bufnr = bufnr })
							end)
						end

						return true
					end
				end
			end

			return false
		end

		-- map("n", "gd", vim.lsp.buf.definition, "LSP: goto definition")
		map("n", "gl", vim.diagnostic.open_float, "LSP: show diagnostic")
		map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: signature help")
		map("n", "K", function()
			local width = math.floor(vim.o.columns * 0.8)
			vim.lsp.buf.hover({ border = "single", max_height = 30, max_width = width })
		end, "LSP: hover doc")
		map("n", "<C-s>", function()
			if has_lsp_client("eslint") and vim.fn.exists(":LspEslintFixAll") == 2 then
				vim.cmd("LspEslintFixAll")
			end

			if has_lsp_client("ts_ls") then
				code_action("source.organizeImports", "ts_ls")
			end

			pcall(vim.lsp.buf.format, {
				bufnr = bufnr,
				filter = function(client)
					return client.name ~= "eslint"
				end,
			})
			vim.cmd("write")
		end, "LSP: fix, format and save")
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
