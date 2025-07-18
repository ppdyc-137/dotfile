return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                component_separators = "",
                section_separators = "",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
}
