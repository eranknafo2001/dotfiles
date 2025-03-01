{ inputs, config, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      my.hyprland = config.my.hyprland;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.eran = import ../home/eran/default.nix;
  };

  users = {
    mutableUsers = false;
    users = {
      eran = {
        isNormalUser = true;
        description = "Eran Knafo";
        extraGroups = [ "networkmanager" "wheel" "dialout" ];
        hashedPassword =
          "$y$j9T$tD9ynCDDUUQt7V.SvsZI5.$UXPNkK4PIpnaIr5bT3AHqsSNLm8ZAWCJm4/4qYF0KaC";
      };
      root.hashedPassword =
        "$y$j9T$jPygLq0cBfqbzSBjnLchA1$0gOHnctTMQQCtqFuW2AmjCOhYltrFQYD7eRGwfX6K45";
    };
  };

  nix.settings.trusted-users = [ "eran" ];
}
