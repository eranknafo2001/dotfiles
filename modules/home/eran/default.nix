{...}: {
  imports = [
    ./apps.nix
    ./styilx.nix
    ./git.nix
    ./ssh.nix
    ./tailscale.nix
    ./term/default.nix
    ./nixvim.nix
    ./vscode.nix
    ./shell.nix
    ./hyprland/default.nix
    ./firefox/default.nix
    ./ai/default.nix
    ./sops.nix
    ./helix.nix
    ./bevy.nix
    ./zed.nix
    ./automount.nix
  ];

  home = {
    username = "eran";
    homeDirectory = "/home/eran";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowUnfreePredicate = _: true;
    allowUnfree = true;
  };
}
