{ pkgs, inputs, ... }: {
  home.packages = [ inputs.ghostty.packages.x86_64-linux.default ];
  home.file.".config/ghostty/config".text = ''
    command = ${pkgs.fish}/bin/fish
    shell-integration = fish
    background-opacity = 0.9
    background-blur = 20
  '';
  # programs.kitty = {
  #   enable = true;
  #   settings = {
  #     shell = "${pkgs.fish}/bin/fish";
  #     term = "xterm-256color";
  #   };
  # };
}
