# Home Manager configuration for eran@eranpc
{mkHomeConfiguration, ...}: {
  flake.homeConfigurations."eran@eranpc" = mkHomeConfiguration {
    username = "eran";
    hostname = "eranpc";
    myConf = ../../systems/eranpc/my-conf.nix;
  };
}
