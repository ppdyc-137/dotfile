local keyset = vim.keymap.set
local keydel = vim.keymap.del

keyset({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true })

keyset("", "s", "<nop>")
keyset("", "q", "<nop>")
keyset("", "S", "<cmd>w<cr>")
keyset("", "Q", "<cmd>q<cr>")

keyset("", "J", "5j")
keyset("", "K", "5k")
keyset("", "H", "5h")
keyset("", "L", "5l")

keyset("", "<leader>l", "<C-w>l")
keyset("", "<leader>h", "<C-w>h")
keyset("", "<leader>j", "<C-w>j")
keyset("", "<leader>k", "<C-w>k")

keyset("", "<C-h>", "<cmd>bprevious<cr>", { noremap = true })
keyset("", "<C-l>", "<cmd>bnext<cr>", { noremap = true })

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

keyset("n", "<leader>K", "<cmd>norm! K<cr>")
keyset("n", "<leader>L", "<cmd>Lazy<cr>")

keyset("n", "gh", function() vim.lsp.buf.hover() end)

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
keyset("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keyset("n", "g]", diagnostic_goto(true), { desc = "Next Diagnostic" })
keyset("n", "g[", diagnostic_goto(false), { desc = "Prev Diagnostic" })

keyset("n", "<A-o>", "<cmd>LspClangdSwitchSourceHeader<cr>")
