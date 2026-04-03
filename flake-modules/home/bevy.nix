{...}: {
  flake.homeModules.bevy =
    {pkgs, ...}: {
      home.packages = [pkgs.bevy-cli];
    }
;
}
