-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keyset = vim.keymap.set
local keydel = vim.keymap.del

-- quit
keyset("n", "q", "<nop>")
keyset("n", "Q", "<cmd>q<cr>", { desc = "Quit" })

-- save
keyset("n", "S", "<cmd>w<cr>", { desc = "Save" })

-- navigation
keydel("n", "H")
keydel("n", "L")
keyset("", "H", "5h")
keyset("", "J", "5j")
keyset("", "K", "5k")
keyset("", "L", "5l")

-- window navigation
keydel("n", "<leader>l")
keyset("n", "<leader>h", "<C-w>h", { desc = "Go to the left window" })
keyset("n", "<leader>j", "<C-w>j", { desc = "Go to the down window" })
keyset("n", "<leader>k", "<C-w>k", { desc = "Go to the up window" })
keyset("n", "<leader>l", "<C-w>l", { desc = "Go to the right window" })

-- buffer
keydel("n", "<C-h>")
keydel("n", "<C-j>")
keydel("n", "<C-k>")
keydel("n", "<C-l>")
keyset("n", "<C-h>", "<cmd>bprevious<cr>")
keyset("n", "<C-l>", "<cmd>bnext<cr>")
keyset("n", "W", "<cmd>bdelete<cr>")

keydel("n", "<leader>L")
keyset("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

keyset("n", "s", "<nop>")
keyset("n", "sl", function()
  vim.opt.splitright = true
  vim.cmd("vsplit")
end)
keyset("n", "sh", function()
  vim.opt.splitright = false
  vim.cmd("vsplit")
end)
keyset("n", "sj", function()
  vim.opt.splitbelow = true
  vim.cmd("split")
end)
keyset("n", "sk", function()
  vim.opt.splitbelow = false
  vim.cmd("split")
end)
