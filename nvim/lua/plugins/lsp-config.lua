return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                float = {
                    header = "",
                },
            })
        end,
    }
}
