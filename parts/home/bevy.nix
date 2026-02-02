# Bevy game engine tooling
{...}: {
  homeModules = [
    ({pkgs, ...}: {
      home.packages = [pkgs.bevy-cli];
    })
  ];
}
