{
  pkgs,
  config,
  lib,
  ...
}: let
  opencode-wrapper = lib.mkSecretWrapper pkgs.sst-opencode-ai [
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
  sops.secrets = {
    openrouter_key = {};
    openai_key = {};
    gemini_key = {};
  };
}
