-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Configuration for Makefile tabs and disabling autoformatting in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.bo.expandtab = false -- Use tabs instead of spaces
    vim.bo.shiftwidth = 4 -- Set tab width to 4 spaces (or your preferred width)
    vim.bo.softtabstop = 4 -- Match soft tab stop to tab width
    vim.bo.tabstop = 4
    vim.b.autoformat = false -- Disable autoformatting for Makefiles
  end,
})
