{...}: {
  flake.nixosModules.star-citizen = {
    inputs,
    pkgs,
    system,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      inputs.nix-citizen.packages.${system}.star-citizen
    ];
  };
}
