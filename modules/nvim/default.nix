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

        programs.neovim = {
          enable = true;
          defaultEditor = true;
          vimAlias = true;
          extraPackages = with pkgs; [
            luarocks
            xclip
            tree-sitter
            unzip
            gcc
            gnumake
          ];
        };
      };
  };
}
