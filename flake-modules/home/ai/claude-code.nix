{...}: {
  flake.homeModules.ai-claude-code = {pkgs, ...}: {
    programs.claude-code = {
      enable = true;
      package = pkgs.llm-agents.claude-code;
    };
  };
}
