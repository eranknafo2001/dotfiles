{
  pkgs,
  config,
  lib,
  ...
}: let
  codex-wrapper = lib.mkSecretWrapper pkgs.codex [
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
  home.packages = [codex-wrapper];
  sops.secrets = {
    openai_key = {};
    gemini_key = {};
  };
}
