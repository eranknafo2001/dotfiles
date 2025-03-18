{
  pkgs,
  lib,
  hyprland-config,
  ...
}: let
  cfg = hyprland-config;
  changeWallpaper =
    pkgs.writeShellScriptBin "changeWallpaper"
    (lib.strings.concatMapStringsSep "\n" (monitor: ''
        hyprctl hyprpaper wallpaper "${monitor.name},$(find -L ${./wallpapers} -type f | shuf -n 1)"'') cfg.monitors);
in {
  options.my.hyprland.hyprpaper = {inherit changeWallpaper;};
  config = {
    home.packages = [changeWallpaper];

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = true;
        preload =
          builtins.map (name: "${./wallpapers}/${name}")
          (builtins.attrNames (builtins.readDir ./wallpapers));
      };
    };
  };
}
