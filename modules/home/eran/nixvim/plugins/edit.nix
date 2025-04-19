{config, ...}: let
  inherit (config.lib.nixvim) mkRaw listToUnkeyedAttrs;
in {
  programs.nixvim.plugins = {
    nix-develop = {
      enable = true;
      lazyLoad.settings.cmd = ["NixDevelop" "NixShell" "RiffShell"];
    };
    nvim-surround = {
      enable = true;
      lazyLoad.settings.keys = [
        ((listToUnkeyedAttrs ["<C-g>s"]) // {})
        ((listToUnkeyedAttrs ["<C-g>S"]) // {})
        ((listToUnkeyedAttrs ["ys"]) // {})
        ((listToUnkeyedAttrs ["yss"]) // {})
        ((listToUnkeyedAttrs ["yS"]) // {})
        ((listToUnkeyedAttrs ["ySS"]) // {})
        ((listToUnkeyedAttrs ["s"]) // {mode = "x";}) # visual mode
        ((listToUnkeyedAttrs ["gs"]) // {mode = "x";}) # visual mode
        ((listToUnkeyedAttrs ["ds"]) // {})
        ((listToUnkeyedAttrs ["cs"]) // {})
        ((listToUnkeyedAttrs ["cS"]) // {})
      ];
      settings.keymaps = mkRaw ''
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
    ts-autotag = {
      enable = true;
      lazyLoad.settings.ft = [
        "html"
        "svelte"
        "typescriptreact"
        "xml"
        "heex"
        "glimmer"
        "templ"
        "astro"
        "eruby"
        "liquid"
        "vue"
        "htmlangular"
        "htmldjango"
        "markdown"
        "php"
        "twig"
        "blade"
        "elixir"
        "javascriptreact"
        "javascript.jsx"
        "typescript.tsx"
        "javascript"
        "typescript"
        "rescript"
        "handlebars"
        "hbs"
        "rust"
      ];
    };
    ts-comments = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    todo-comments = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    mini = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      modules = {
        ai = {
          n_lines = 100;
          silent = false;
        };
        pairs = {
          mods = {
            insert = true;
            command = false;
            terminal = false;
          };
        };
      };
    };
  };
}
