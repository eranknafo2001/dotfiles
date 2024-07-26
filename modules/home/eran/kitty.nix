{ pkgs, lib, config, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hack Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "Hack" ]; });
    };
    settings = {
      shell = "${pkgs.fish}/bin/fish";
      background_opacity = "0.8";
      term = "xterm-256color";
    };
  };
}
