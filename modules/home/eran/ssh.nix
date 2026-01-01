{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    # matchBlocks.eranpc.proxyCommand = "fish";
  };
}
