{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];
  programs.nvf = {
    enable = false;
    settings.vim = {
      vimAlias = true;
      lsp = {enable = true;};
      languages = {
        nix = {
          enable = true;
          treesitter.enable = true;
        };
        rust = {enable = true;};
        ts = {enable = true;};
      };
      assistant.copilot = {
        enable = true;
        cmp.enable = true;
      };
      autocomplete.blink-cmp.enable = true;
      treesitter.enable = true;
      fzf-lua.enable = true;
    };
  };
}
