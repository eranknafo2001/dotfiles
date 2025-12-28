{
  pkgs,
  config,
  lib,
  ...
}: let
  opencode-wrapper = lib.mkSecretWrapper pkgs.opencode [
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
  home.packages = [opencode-wrapper];
  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    autoupdate = true;
    tui.scroll_speed = 0.7;
    mcp = {
      context7 = {
        type = "remote";
        url = "https://mcp.context7.com/mcp";
        enabled = true;
      };
    };
  };
  sops.secrets = {
    openrouter_key = {};
    openai_key = {};
    gemini_key = {};
  };
}
