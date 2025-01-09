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
        ["<C-k>"] =  {"snippet_backward", "scroll_documentation_up", "fallback" },
        ["<C-j>"] = { "snippet_forward","scroll_documentation_down", "fallback" },
      },
    },
    vim.api.nvim_command("highlight link BlinkCmpLabelDetail LspCodeLens"),
  },
}
