{lib, ...}: {
  options.my = {
    gaming = {enable = lib.mkEnableOption "gaming";};
    docker = {enable = lib.mkEnableOption "docker";};
    hyprland = {
      enable = lib.mkEnableOption "hyprland";
      nvidia = lib.mkOption {type = lib.types.bool;};
      battery = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      monitors = lib.mkOption {
        type = with lib.types;
          listOf (submodule {
            options = {
              name = lib.mkOption {type = str;};
              resolution = lib.mkOption {type = str;};
              position = lib.mkOption {type = str;};
              scale = lib.mkOption {type = float;};
            };
          });
      };
    };
    mpd = {enable = lib.mkEnableOption "mpd";};
    rustdesk = {enable = lib.mkEnableOption "rustdesk";};
    solaar = {enable = lib.mkEnableOption "solaar";};
    suwayomi = {enable = lib.mkEnableOption "suwayomi";};
    tailscale = {enable = lib.mkEnableOption "tailscale";};
    sshd = {enable = lib.mkEnableOption "sshd";};
    bluetooth = {enable = lib.mkEnableOption "bluetooth";};
  };
}
