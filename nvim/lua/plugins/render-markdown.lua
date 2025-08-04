return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            file_types = { 'markdown', 'copilot-chat' },
            latex = { enabled = false },
            html = { enabled = false },
            heading = {
                icons = { '' },
            },
            code = {
                style = "normal",
            },
            sign = {
                enabled = false,
            },
        },
        ft = { "markdown", "norg", "rmd", "org", "copilot-chat" },
    }
}
