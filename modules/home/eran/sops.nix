{
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops ../../common/sops.nix];
  sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
}
