{ pkgs, ... }: {
  home.file.".config/nvim".source = ./.;
  home.sessionVariables = { EDITOR = "nvim"; };

  home.packages = with pkgs; [
    unzip
    gcc
    gnumake
    luarocks
    xclip
    wl-clipboard
    tree-sitter
    unzip
    gcc
    gnumake
    nodejs
    cargo
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
