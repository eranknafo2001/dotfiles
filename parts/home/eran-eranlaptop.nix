# Home Manager configuration for eran@eranlaptop
{mkHomeConfiguration, ...}: {
  flake.homeConfigurations."eran@eranlaptop" = mkHomeConfiguration {
    username = "eran";
    hostname = "eranlaptop";
    myConf = ../../systems/eranlaptop/my-conf.nix;
    homeModules = ../../modules/home/eran/default.nix;
  };
}
