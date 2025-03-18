{
  description = "Eran Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.nur.follows = "nur";
    };

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = { self, nixpkgs, nur, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      hyprland-config = {
        enable = true;
        monitors = [
          {
            name = "DP-4";
            position = "0x0";
            resolution = "preferred";
            scale = 1.0;
          }
          {
            name = "HDMI-A-3";
            position = "1920x0";
            resolution = "preferred";
            scale = 1.0;
          }
        ];
      };
    in {
      nixosConfigurations = {
        eranpc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit system inputs hyprland-config; };
          modules =
            [ nur.modules.nixos.default ./systems/eranpc/configuration.nix ];
        };
      };

      homeConfigurations = {
        eran = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs hyprland-config; };
          modules = [ ./modules/home/eran/default.nix ];
        };
      };
    };
}
