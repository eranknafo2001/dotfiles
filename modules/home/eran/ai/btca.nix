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
      repos = [
        {
          name = "iced";
          url = "https://github.com/iced-rs/iced";
          branch = "master";
        }
        {
          name = "svelte";
          url = "https://github.com/sveltejs/svelte.dev";
          branch = "main";
        }
      ];
      model = "big-pickle";
      provider = "opencode";
    };
  };
}
