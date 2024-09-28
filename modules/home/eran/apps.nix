{ pkgs, ... }: {
  home.packages = with pkgs; [ ytmdesktop vesktop nixfmt devenv vdhcoapp nmap ];
}
