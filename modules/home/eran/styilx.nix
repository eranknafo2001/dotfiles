{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix ../../common/stylix.nix];

  # CJK (Chinese, Japanese, Korean) font support
  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  # Enable fontconfig for proper font fallback
  fonts.fontconfig.enable = true;

  stylix = {
    targets = {
      hyprpaper.enable = lib.mkForce false;
      hyprlock.enable = lib.mkForce false;
      vim.enable = false;
      zed.enable = false;
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
