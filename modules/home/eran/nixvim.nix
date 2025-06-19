{
  inputs,
  system,
  config,
  lib,
  ...
}: let
  nvim = inputs.nvim.packages.${system}.default;

  nvim-wrapper = lib.mkSecretWrapper nvim [
    {
      name = "OPENAI_API_KEY";
      inherit (config.sops.secrets.openai_key) path;
    }
    {
      name = "ANTHROPIC_API_KEY";
      inherit (config.sops.secrets.anthropic_key) path;
    }
    {
      name = "TAVILY_API_KEY";
      inherit (config.sops.secrets.tavily_key) path;
    }
  ];
in {
  sops.secrets = {
    anthropic_key = {};
    openai_key = {};
    tavily_key = {};
  };
  home.packages = [nvim-wrapper];
  home.sessionVariables = {
    EDITOR = "${nvim-wrapper}/bin/nvim";
  };
}
