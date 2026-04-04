{...}: {
  flake.homeModules.tailscale = {...}: {
    services.trayscale.enable = true;
  };
}
