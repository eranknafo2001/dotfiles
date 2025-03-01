{ ... }: {
  imports = [
    ./apps.nix
    ./styilx.nix
    ./git.nix
    ./kitty.nix
    ./nvim/default.nix
    # ./nnvim/default.nix
    ./shell/default.nix
    ./hyprland/default.nix
    ./firefox/default.nix
  ];
  home.username = "eran";
  home.homeDirectory = "/home/eran";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
