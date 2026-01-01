{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.my.btca;
  opencodeEnabled = config.my.opencode.enable;
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = opencodeEnabled;
        message = "btca requires opencode to be enabled (my.opencode.enable = true)";
      }
    ];

    home.packages = [pkgs.btca];
    xdg.configFile."btca/btca.json".text = builtins.toJSON {
      reposDirectory = "~/.local/share/btca/repos";
      port = 3420;
      maxInstances = 5;
      model = "big-pickle";
      provider = "opencode";
      inherit (cfg) repos;
    };
  };
}
