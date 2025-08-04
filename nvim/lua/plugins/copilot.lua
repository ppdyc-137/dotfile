return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {
                auto_trigger = false,
            },
        },
        keys = {
            {
                "<C-k>",
                function()
                    if vim.g.lsp_enable then
                        local cmp = require("blink.cmp")
                        if cmp.is_visible() then
                            cmp.hide()
                        end
                    end
                    require("copilot.suggestion").next()
                end,
                mode = { "i" }
            },
            { "<C-l>", function() require("copilot.suggestion").accept() end, mode = { "i" } }
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            highlight_headers = false,
            separator = '---',
            error_header = '> [!ERROR] Error',
            window = {
                layout = 'vertical',
                width = 0.4,
            },
            model = 'claude-sonnet-4',
        },
        keys = {
            { "<leader>a", "<cmd>CopilotChat<cr>", { silent = true }, mode = { "n", "x" } }
        },
    },
}
