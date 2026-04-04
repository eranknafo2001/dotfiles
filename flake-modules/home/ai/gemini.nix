{...}: {
  flake.homeModules.ai-gemini = {pkgs, ...}: {
    home.packages = [pkgs.llm-agents.gemini-cli];
  };
}
