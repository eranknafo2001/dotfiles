{ lib, ... }: {
  stylix.targets.hyprpaper.enable = lib.mkForce false;
  stylix.targets.vim.enable = false;
}
