{...}: {
  flake.homeModules.sops = {
    inputs,
    config,
    ...
  }: {
    imports = [inputs.sops-nix.homeManagerModules.sops];
    sops = {
      defaultSopsFile = ../../secrets.yaml;
      age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    };
  };
}
