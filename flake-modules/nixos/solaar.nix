{...}: {
  flake.nixosModules.solaar = {inputs, ...}: {
    imports = [inputs.solaar.nixosModules.default];
    services.solaar.enable = true;
  };
}
