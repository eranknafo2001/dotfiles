{config, ...}: {
  programs.nixvim.plugins = {
    nix-develop.enable = true;
    nvim-surround = {
      enable = true;
      settings.keymaps = config.lib.nixvim.mkRaw ''
        {
          insert = "<C-g>s";
          insert_line = "<C-g>S";
          normal = "ys";
          normal_cur = "yss";
          normal_line = "yS";
          normal_cur_line = "ySS";
          visual = "s";
          visual_line = "gs";
          delete = "ds";
          change = "cs";
          change_line = "cS";
        }
      '';
    };
    ts-autotag.enable = true;
    ts-comments.enable = true;
  };
}
