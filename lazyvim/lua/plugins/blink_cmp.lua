return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = { selection = "auto_insert" },
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
      },
      signature = { enabled = true },
    },
    vim.api.nvim_command("highlight link BlinkCmpLabelDetail LspCodeLens"),
  },
}
