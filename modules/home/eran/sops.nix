{inputs, ...}: {
  imports = [inputs.sops-nix.homeManagerModules.sops ../../common/sops.nix];
}
