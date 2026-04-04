{...}: {
  flake.homeModules.term = {
    packages,
    system,
    ...
  }: {
    home.packages = [packages.${system}.ghostty-eran];
  };
}
