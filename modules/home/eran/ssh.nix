{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = true;
    # matchBlocks.eranpc.proxyCommand = "fish";
  };
}
