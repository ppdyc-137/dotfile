local function get_root()
    local folders = vim.g.WorkspaceFolders
    if folders and #folders > 0 then
        return folders[1]
    end
end

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bufdelete = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            terminal = {
                enabled = true,
                win = {
                    style = "minimal",
                },
            },
            lazygit = { enabled = true },
            dashboard = {
                preset = {
                    keys = {
                        { icon = " ", key = "<space>", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')", },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')", },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')", },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    { title = "Keymaps", icon = " ", padding = 1 },
                    { section = "keys", gap = 1, padding = 1, indent = 2 },
                    { title = "Configs", icon = " ", padding = 1 },
                    {
                        gap = 1,
                        padding = 1,
                        indent = 2,
                        { key = "v", desc = "Neovim", icon = " ", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
                        { key = "f", desc = "Fish", icon = "󰈺 ", action = ":e ~/.config/fish/config.fish", },
                        { key = "h", desc = "Hyprland", icon = " ", action = ":e ~/.config/hypr/hyprland.conf", },
                        { key = "t", desc = "Kitty", icon = " ", action = ":e ~/.config/kitty/kitty.conf", },
                    },
                },
            },
            image = {},
            picker = { focus = "list" },
            words = {},
        },
        keys = {
            { "W",         function() Snacks.bufdelete.delete() end },

            { "<C-`>",     function() Snacks.terminal.toggle(nil, { cwd = get_root() }) end, mode = { "n", "t" } },

            { "<leader>g", function() Snacks.lazygit() end },
            { "<leader>e", function() Snacks.explorer() end },

            { "ff",        function() Snacks.picker.files() end },
            { "fF",        function() Snacks.picker.files({ cwd = get_root() }) end },
            { "fg",        function() Snacks.picker.grep() end },
            { "fG",        function() Snacks.picker.grep({ cwd = get_root() }) end },
        },
    },
}
