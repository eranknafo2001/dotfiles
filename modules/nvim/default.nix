{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.my.nvim;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.my.nvim = {
    enable = lib.mkEnableOption "eran";
  };
  config = lib.mkIf cfg.enable {
    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      users.eran = { config, pkgs, ... }:
        {
          home.file.".config/nvim".source = ./.;
          home.sessionVariables = {
            EDITOR = "nvim";
          };

          programs.neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
          };
        };
    };
  };
}
