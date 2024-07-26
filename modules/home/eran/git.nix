{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Eran Knafo";
    userEmail = "eranknafo2001@gmail.com";
    diff-so-fancy.enable = true;
    aliases = {
      co = "checkout";
      br = "brunch";
      st = "status";
    };
  };
}
