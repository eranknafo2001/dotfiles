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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nur.follows = "nur";
      };
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

    ghostty = {
      url = "github:ghostty-org/ghostty/1.1.x";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      eranpc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [./my-config-structure.nix nur.modules.nixos.default ./systems/eranpc/configuration.nix ./systems/eranpc/my-conf.nix];
      };
      eranlaptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [./my-config-structure.nix nur.modules.nixos.default ./systems/eranlaptop/configuration.nix ./systems/eranlaptop/my-conf.nix];
      };
    };

    homeConfigurations = {
      "eran@eranpc" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit system inputs;};
        modules = [./my-config-structure.nix ./systems/eranpc/my-conf.nix ./modules/home/eran/default.nix];
      };
      "eran@eranlaptop" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit system inputs;};
        modules = [./my-config-structure.nix ./systems/eranlaptop/my-conf.nix ./modules/home/eran/default.nix];
      };
    };
  };
}
