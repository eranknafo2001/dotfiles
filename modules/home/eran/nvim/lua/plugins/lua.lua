return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").sumneko_lua.setup({
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      exclude = { "sumneko_lua", "stylua" }, -- Exclude the Lua language server
    },
  },
}
