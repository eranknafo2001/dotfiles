# SSH client configuration
{...}: {
  homeModules = [
    ({...}: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
      };
    })
  ];
}
