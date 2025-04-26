{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks.eranpc.proxyCommand = "fish";
  };
}
