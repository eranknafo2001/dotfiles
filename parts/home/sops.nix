# SOPS secrets for Home Manager
{inputs, ...}: {
  homeModules = [
    inputs.sops-nix.homeManagerModules.sops
    # Common sops configuration
    ({...}: {
      sops = {
        defaultSopsFile = ../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    })
    # User-specific sops configuration
    ({config, ...}: {
      sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    })
  ];
}
