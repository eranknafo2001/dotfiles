return {
  "mbbill/undotree",
  keys = { { "<F4>", vim.cmd.UndotreeToggle } },
  cmd = "UndotreeToggle",
  init = function()
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
