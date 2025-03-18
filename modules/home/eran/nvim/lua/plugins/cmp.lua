return {
  "saghen/blink.cmp",
  ---@param opts blink.cmp.Config
  opts = function(_, opts)
    opts.keymap["<C-k>"] = { 'select_prev', 'fallback' }
    opts.keymap["<C-j>"] = { 'select_next', 'fallback' }
  end,
}
