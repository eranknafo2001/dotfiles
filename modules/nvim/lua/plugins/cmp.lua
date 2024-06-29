return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    local only_if_visible = function(callback)
      return function(fallback)
        if cmp.visible() then
          callback(fallback)
        else
          fallback()
        end
      end
    end

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-k>"] = cmp.mapping(
        only_if_visible(function()
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        end),
        { "i", "s" }
      ),
      ["<C-j>"] = cmp.mapping(
        only_if_visible(function()
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        end),
        { "i", "s" }
      ),
    })
  end,
}
