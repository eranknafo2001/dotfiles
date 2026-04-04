{...}: {
  flake.homeModules.ai-pi = {
    config,
    lib,
    pkgs,
    ...
  }: let
    pi-wrapper = lib.mkSecretWrapper pkgs.llm-agents.pi [
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
      {
        name = "OPENCODE_API_KEY";
        inherit (config.sops.secrets.opencode_key) path;
      }
    ];
  in {
    home.packages = [pi-wrapper];
    sops.secrets = {
      openrouter_key = {};
      openai_key = {};
      gemini_key = {};
      opencode_key = {};
    };
  };
}
