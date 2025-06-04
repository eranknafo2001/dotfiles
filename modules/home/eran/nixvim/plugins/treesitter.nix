_: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
    treesitter-context = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings.max_lines = 3;
    };
    treesitter-textobjects = {
      enable = true;
    };
    treesitter-refactor = {
      enable = true;
    };
  };
}
