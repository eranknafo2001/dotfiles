{config, ...}: let
  inherit (config.lib.nixvim) mkRaw listToUnkeyedAttrs;
in {
  programs.nixvim.plugins = {
    persistence = {
      enable = true;
      lazyLoad.settings = {
        event = "BufReadPre";
        lazy = true;
        keys = [
          ((listToUnkeyedAttrs ["<leader>qs" (mkRaw ''function() require("persistence").load() end'')]) // {desc = "Restore Session";})
          ((listToUnkeyedAttrs ["<leader>qS" (mkRaw ''function() require("persistence").select() end'')]) // {desc = "Select Session";})
          ((listToUnkeyedAttrs ["<leader>ql" (mkRaw ''function() require("persistence").load({ last = true }) end'')]) // {desc = "Restore Last Session";})
          ((listToUnkeyedAttrs ["<leader>qd" (mkRaw ''function() require("persistence").stop() end'')]) // {desc = "Don't Save Current Session";})
        ];
      };
    };
  };
}
