# SOPS secrets management - NixOS configuration
{inputs, ...}: {
  nixosModules = [
    inputs.sops-nix.nixosModules.sops
    # Common sops configuration
    ({...}: {
      sops = {
        defaultSopsFile = ../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    })
    # System-specific sops configuration
    ({config, ...}: {
      sops = {
        age = {
          sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
          generateKey = true;
        };
        secrets.sops_user_private_key = {
          mode = "0600";
          owner = config.users.users.eran.name;
          inherit (config.users.users.eran) group;
          path = "${config.users.users.eran.home}/.config/sops/age/keys.txt";
        };
      };
    })
  ];
}
