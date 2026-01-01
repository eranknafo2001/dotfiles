{
  config,
  lib,
  inputs,
  system,
  ...
}: let
  cfg = config.my.opencode;
  isBtcaEnabled = config.my.btca.enable;
  btcaRepos = config.my.btca.repos;
  btcaPrompt = lib.optionalString isBtcaEnabled ''
    ## btca
    Trigger: user says "use btca" (for codebase/docs questions).

    Run:
    - btca ask -t <tech> -q "<question>"

    Available <tech>: ${(lib.strings.concatMapStringsSep ", " (repo: repo.name) btcaRepos)}
  '';
  opencode-wrapper = lib.mkSecretWrapper inputs.opencode.packages.${system}.default [
    {
      name = "OPENROUTER_API_KEY";
      inherit (config.sops.secrets.openrouter_key) path;
    }
    {
      name = "OPENAI_API_KEY";
      inherit (config.sops.secrets.openai_key) path;
    }
    {
      name = "GEMINI_API_KEY";
      inherit (config.sops.secrets.gemini_key) path;
    }
  ];
in {
  config = lib.mkIf cfg.enable {
    home.packages = [opencode-wrapper];
    xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      default_agent = "plan";
      autoupdate = false;
      tui.scroll_speed = 0.7;
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
          enabled = true;
        };
      };
    };
    xdg.configFile."opencode/AGENTS.md".text = ''
      # Agent Guidelines
      ${btcaPrompt}
    '';
    sops.secrets = {
      openrouter_key = {};
      openai_key = {};
      gemini_key = {};
    };
  };
}
