{config, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      openclaw = {
        user = "openclaw";
        hostname = "157.180.87.192";
      };
    };
  };
  sops.secrets = {
    ssh_private_key = {
      path = "~/.ssh/id_ed25519";
      mode = "0644";
    };
    ssh_public_key = {
      path = "~/.ssh/id_ed25519.pub";
      mode = "0644";
    };
  };
}
