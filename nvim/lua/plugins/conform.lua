if not vim.g.lsp_enable then return {} end

return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                cpp = { "clang-format" },
                python = { "black" },
                sh = { "shfmt" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
        keys = {
            { "<leader>f", function() require("conform").format() end, mode = { "n", "x" } }
        },
    },
}
