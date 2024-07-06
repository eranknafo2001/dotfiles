{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.eran;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    home-manager
    pavucontrol
    htop
    nvtop
  ];

  fonts = {
    enableDefaultPackages = true;
  };

  programs.firefox.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/eran/dotfiles";
  };

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_IL";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "he_IL.UTF-8";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.eran = { config, pkgs, ... }:
      {
        home.username = "eran";
        home.homeDirectory = "/home/eran";

        home.stateVersion = "24.05";

        programs.home-manager.enable = true;
      };
  };
  users = {
    mutableUsers = false;
    users = {
      eran = {
        isNormalUser = true;
        description = "Eran Knafo";
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPassword = "$y$j9T$tD9ynCDDUUQt7V.SvsZI5.$UXPNkK4PIpnaIr5bT3AHqsSNLm8ZAWCJm4/4qYF0KaC";
      };
      root.hashedPassword = "$y$j9T$jPygLq0cBfqbzSBjnLchA1$0gOHnctTMQQCtqFuW2AmjCOhYltrFQYD7eRGwfX6K45";
    };
  };
  nix.settings.trusted-users = [ "eran" ];
}
