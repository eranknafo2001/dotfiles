# Base Home Manager configuration
{...}: {
  homeModules = [
    ({...}: {
      programs.home-manager.enable = true;
      nixpkgs.config = {
        allowUnfreePredicate = _: true;
        allowUnfree = true;
      };
    })
  ];
}
