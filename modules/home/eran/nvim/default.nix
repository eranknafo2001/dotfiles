{ pkgs, ... }: {
  home.file."./.config/nvim/" = {
    source = ./.;
    recursive = true;
  };

  home.sessionVariables = { EDITOR = "nvim"; };
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      fd
      ripgrep
      git
      lazygit
      fzf

      wl-clipboard
      gcc
      gnumake
      luarocks
      unzip
      nodejs

      lua-language-server
      stylua
    ];
  };
}
