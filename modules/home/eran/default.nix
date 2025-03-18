{ ... }: {
  imports = [
    ./apps.nix
    ./styilx.nix
    ./git.nix
    ./term/default.nix
    # ./nvim/default.nix
    ./nixvim/default.nix
    # ./nvf/default.nix
    ./vscode.nix
    ./shell/default.nix
    ./hyprland/default.nix
    ./firefox/default.nix
  ];

  home = {
    username = "eran";
    homeDirectory = "/home/eran";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
