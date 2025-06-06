-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.g.snacks_animate = false
vim.g.ai_cmp = false

vim.opt.clipboard = ""
vim.opt.relativenumber = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.diagnostic.config({
  virtual_text = false,
})
