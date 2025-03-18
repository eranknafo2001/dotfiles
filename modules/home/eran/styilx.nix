{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix ../../common/stylix.nix];
  stylix = {
    targets = {
      hyprpaper.enable = lib.mkForce false;
      hyprlock.enable = lib.mkForce false;
      vim.enable = false;
      vscode.profileNames = ["default"];
    };
    opacity = {terminal = 0.8;};
    fonts = {
      monospace = {
        name = "Hack Nerd Font";
        package = pkgs.nerd-fonts.hack;
      };
    };
  };
}
