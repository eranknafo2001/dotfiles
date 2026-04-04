{...}: {
  flake.homeModules.ai-btca = {
    pkgs,
    config,
    lib,
    ...
  }: let
    cfg = config.my.btca;
  in {
    options.my.btca.repos = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            name = lib.mkOption {type = str;};
            url = lib.mkOption {type = str;};
            branch = lib.mkOption {
              type = str;
              default = "main";
            };
            specialNotes = lib.mkOption {type = str;};
          };
        });
      default = [];
    };

    config = {
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
  };
}
