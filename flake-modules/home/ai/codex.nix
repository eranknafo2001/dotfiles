{...}: {
  flake.homeModules.ai-codex = {
    pkgs,
    config,
    lib,
    ...
  }: let
    codex-wrapper = lib.mkSecretWrapper pkgs.llm-agents.codex [
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
    home.packages = [codex-wrapper];
    sops.secrets = {
      openai_key = {};
      gemini_key = {};
    };
  };
}
