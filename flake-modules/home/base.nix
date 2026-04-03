{...}: {
  flake.homeModules.base = {
    home = {
      username = "eran";
      homeDirectory = "/home/eran";
      stateVersion = "24.05";
    };

    programs.home-manager.enable = true;
    nixpkgs.config = {
      allowUnfreePredicate = _: true;
      allowUnfree = true;
    };
  };
}
