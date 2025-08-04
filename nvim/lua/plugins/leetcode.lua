local leet_arg = "leetcode"

return {
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        lazy = leet_arg ~= vim.fn.argv(0, -1),
        opts = {
            arg = leet_arg,
            cn = {
                enabled = true,
            },
            injector = { ---@type table<lc.lang, lc.inject>
                ["cpp"] = {
                    imports = function()
                        return { "#include <bits/stdc++.h>", "using namespace std;" }
                    end,
                },
            },
        },
    }
}
