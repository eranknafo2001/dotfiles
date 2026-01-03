{
  pkgs,
  lib,
  config,
  inputs,
  system,
  ...
}: let
  cfg = config.my.hyprland;
  changeWallpaper =
    pkgs.writeShellScriptBin "changeWallpaper"
    (lib.strings.concatMapStringsSep "\n" (monitor: ''
      hyprctl hyprpaper wallpaper "${monitor.name},$(find -L ${
        ./wallpapers
      } -type f | shuf -n 1)"'')
    cfg.monitors);
in {
  config = lib.mkIf cfg.enable {
    home.packages = [changeWallpaper];

    services.hyprpaper = {
      enable = true;
      package = inputs.hyprpaper.packages.${system}.default;
      settings = {
        ipc = true;
        wallpaper =
          (lib.map (monitor: {
            monitor = monitor.name;
            path = "${./wallpapers}/1.jpg";
          mode = "cover";
          }) cfg.monitors  );
        preload =
          builtins.map (name: "${./wallpapers}/${name}")
          (builtins.attrNames (builtins.readDir ./wallpapers));
      };
    };
  };
}
