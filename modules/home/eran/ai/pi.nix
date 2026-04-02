{
  config,
  lib,
  inputs,
  system,
  ...
}: let
  cfg = config.my.pi-ai;
  pi-wrapper = lib.mkSecretWrapper inputs.llm-agents.packages.${system}.pi [
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
    home.packages = [pi-wrapper];
    sops.secrets = {
      openrouter_key = {};
      openai_key = {};
      gemini_key = {};
    };
  };
}
