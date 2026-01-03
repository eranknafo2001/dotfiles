{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.hyprland;
  changeWallpaper =
    pkgs.writeShellScriptBin "changeWallpaper"
    ''
      HYPRPAPER_SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.hyprpaper.sock"
      if [[ ! -S "$HYPRPAPER_SOCK" ]]; then
        echo "hyprpaper socket not found at $HYPRPAPER_SOCK"
        exit 1
      fi
      WALLPAPER="$(find -L ${./wallpapers} -type f | shuf -n 1)"
      ${lib.strings.concatMapStringsSep "\n" (monitor: ''
        echo "wallpaper = ${monitor.name},$WALLPAPER" | ${pkgs.socat}/bin/socat - UNIX-CONNECT:"$HYPRPAPER_SOCK"
      '') cfg.monitors}
    '';
in {
  config = lib.mkIf cfg.enable {
    home.packages = [changeWallpaper];

    services.hyprpaper = {
      enable = true;
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
