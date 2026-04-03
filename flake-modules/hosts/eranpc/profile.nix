{...}: {
  flake.nixosModules.eranpc-profile = {
    my.hyprland = {
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
  };

  flake.homeModules.eranpc-home-profile = {
    my.hyprland = {
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
  };
}
