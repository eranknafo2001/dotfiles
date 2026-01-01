{lib, ...}: {
  options.my = {
    gaming.enable = lib.mkEnableOption "gaming";
    docker.enable = lib.mkEnableOption "docker";
    hyprland = {
      enable = lib.mkEnableOption "hyprland";
      nvidia = lib.mkOption {type = lib.types.bool;};
      battery = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      asus-nmcli-fix = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      bar = lib.mkOption {
        type = lib.types.enum ["waybar" "eww"];
        default = "waybar";
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
    mpd.enable = lib.mkEnableOption "mpd";
    rustdesk.enable = lib.mkEnableOption "rustdesk";
    solaar.enable = lib.mkEnableOption "solaar";
    suwayomi.enable = lib.mkEnableOption "suwayomi";
    tailscale.enable = lib.mkEnableOption "tailscale";
    sshd.enable = lib.mkEnableOption "sshd";
    bluetooth.enable = lib.mkEnableOption "bluetooth";
    kde-connect.enable = lib.mkEnableOption "kde-connect";
    adb.enable = lib.mkEnableOption "adb";
    nix-ld.enable = lib.mkEnableOption "nix-ld";
    vscode.enable = lib.mkEnableOption "vscode";
    zed.enable = lib.mkEnableOption "zed";
    star-citizen.enable = lib.mkEnableOption "star-citizen";
    automount.enable = lib.mkEnableOption "automount";
    opencode.enable = lib.mkEnableOption "opencode";
    btca = {
      enable = lib.mkEnableOption "btca";
      repos = lib.mkOption {
        type = with lib.types;
          listOf (submodule {
            options = {
              name = lib.mkOption {type = str;};
              url = lib.mkOption {type = str;};
              branch = lib.mkOption {
                type = str;
                default = "main";
              };
              specialNotes = lib.mkOption {type = str;};
            };
          });
      };
    };
  };
}
