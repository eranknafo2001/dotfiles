{...}: {
  flake.nixosModules.mpd = {...}: {
    services.mpd = {
      enable = true;
      network.listenAddress = "any";
      startWhenNeeded = true;
    };
  };
}
