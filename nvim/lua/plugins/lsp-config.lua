if not vim.g.lsp_enable then return {} end

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
