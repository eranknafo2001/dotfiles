_: {
  my = {
    automount.enable = true;
    obs.enable = true;
    vr.enable = true;
    star-citizen.enable = false;
    gaming.enable = true;
    docker.enable = true;
    mpd.enable = true;
    solaar.enable = false;
    rustdesk.enable = false;
    suwayomi.enable = false;
    tailscale.enable = true;
    sshd.enable = true;
    opencode.enable = true;
    hyprland = {
      enable = true;
      nvidia = true;
      monitors = [
        {
          name = "DP-4";
          position = "0x0";
          resolution = "preferred";
          scale = 1.0;
        }
        {
          name = "HDMI-A-3";
          position = "1920x0";
          resolution = "preferred";
          scale = 1.0;
        }
      ];
    };
    nix-ld.enable = true;
    zed.enable = true;
  };
}
