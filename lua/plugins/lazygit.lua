vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
})

local group = vim.api.nvim_create_augroup("AutoLazy", { clear = true })
for _, cmd in ipairs({
  "LazyGit", "LazyGitConfig", "LazyGitCurrentFile",
  "LazyGitFilter", "LazyGitFilterCurrentFile",
}) do
  vim.api.nvim_create_autocmd("CmdUndefined", {
    group = group,
    pattern = cmd,
    once = true,
    callback = function()
      vim.pack.add({ { src = "https://github.com/kdheepak/lazygit.nvim" } })
      vim.cmd(cmd)
    end,
  })
end

vim.keymap.set("n", "<leader>g", function()
  vim.cmd("LazyGit")
end, { desc = "Open LazyGit" })
