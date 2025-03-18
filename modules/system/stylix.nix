{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix ../common/stylix.nix];
  # stylix.nixpkgs.pkgs = pkgs;
  stylix.fonts = {
    monospace = {
      name = "Hack Nerd Font";
      package = pkgs.nerd-fonts.hack;
    };
  };
}
