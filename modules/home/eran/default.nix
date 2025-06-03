{...}: {
  imports = [
    ./apps.nix
    ./styilx.nix
    ./git.nix
    ./ssh.nix
    ./tailscale.nix
    # ./projects-cache.nix
    ./term/default.nix
    ./nixvim/default.nix
    ./vscode.nix
    ./shell.nix
    ./hyprland/default.nix
    ./firefox/default.nix
    ./ai/default.nix
    ./sops.nix
    ./helix.nix
    ./bevy.nix
  ];

  home = {
    username = "eran";
    homeDirectory = "/home/eran";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
