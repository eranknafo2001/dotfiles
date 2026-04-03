{...}: {
  flake.homeModules.ai-gemini =
    {pkgs, ...}: {
      home.packages = [pkgs.gemini-cli];
    }
;
}
