return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = { "K", "5k" }
      keys[#keys + 1] = {
        "gh",
        function()
          return vim.lsp.buf.hover()
        end,
        desc = "Hover",
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        -- virtual_text = false,
      },
    },
  },
}
