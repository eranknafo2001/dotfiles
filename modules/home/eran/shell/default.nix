{ pkgs, ... }: {
  home.packages = with pkgs; [ xsel wget tmux file curl dust wl-clipboard ];
  #home.file.".config/starship.toml".source = ./starship.toml;
  services.pueue.enable = true;
  programs = {
    yazi.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
    };
    fd.enable = true;
    feh.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch];
    };
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
