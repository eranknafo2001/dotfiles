{pkgs, ...}: {
  home.packages = [pkgs.ghostty];
  home.file.".config/ghostty/config".text = ''
    command = ${pkgs.fish}/bin/fish
    shell-integration = fish
    background-opacity = 0.9
    background-blur = 20
  '';
}
