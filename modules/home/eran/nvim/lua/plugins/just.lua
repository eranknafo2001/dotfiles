if true then return {} end
return {
  "IndianBoy42/tree-sitter-just",
  lazy = false,
  config = function()
    require("tree-sitter-just").setup({})
  end,
}
