{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.my.nvim;
in
{
  options.my.nvim = {
    enable = lib.mkEnableOption "nvim";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.eran = { config, pkgs, ... }:
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
      };
  };
}
