{...}: {
  my = {
    gaming.enable = false;
    docker.enable = true;
    mpd.enable = true;
    solaar.enable = false;
    rustdesk.enable = false;
    suwayomi.enable = false;
    tailscale.enable = true;
    sshd.enable = false;
    bluetooth.enable = true;
    kde-connect.enable = true;
    adb.enable = true;
    hyprland = {
      enable = true;
      nvidia = false;
      battery = true;
      asus-nmcli-fix = true;
      # bar = "eww";
      monitors = [
        {
          name = "eDP-1";
          position = "0x0";
          resolution = "preferred";
          scale = 1.25;
        }
      ];
    };
    nix-ld.enable = true;
    zed.enable = true;
  };
}
