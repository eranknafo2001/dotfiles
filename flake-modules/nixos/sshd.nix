{...}: {
  flake.nixosModules.sshd = {...}: {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };
  };
}
