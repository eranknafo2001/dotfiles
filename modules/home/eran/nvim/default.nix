{ pkgs, lib, config, inputs, ... }:
{
  home.file.".config/nvim".source = ./.;
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    unzip
    gcc
    gnumake
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      luarocks
      xclip
      wl-clipboard
      tree-sitter
      unzip
      gcc
      gnumake
    ];
  };
}
