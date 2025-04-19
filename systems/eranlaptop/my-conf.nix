{ ... }:
{
  my = {
    gaming.enable = false;
    docker.enable = true;
    mpd.enable = false;
    solaar.enable = false;
    rustdesk.enable = false;
    suwayomi.enable = false;
    tailscale.enable = true;
    sshd.enable = false;
    hyprland = {
      enable = true;
      nvidia = false;
      monitors = [
        {
          name = "eDP-1";
          position = "0x0";
          resolution = "preferred";
          scale = 1.25;
        }
      ];
    };
  };
}
