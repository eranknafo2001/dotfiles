{
  description = "Eran Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    extra-nix-packages = {
      url = "github:eranknafo2001/extra-nix-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "github:eranknafo2001/nvim-config";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

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

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.hyprutils.follows = "hyprland/hyprutils";
      inputs.hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
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

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eww = {
      url = "github:elkowar/eww/v0.6.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-citizen.url = "github:LovingMelody/nix-citizen";

    opencode.url = "github:sst/opencode/v1.0.206";

    # nix-gaming.url = "github:fufexan/nix-gaming";
    # nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

    wivrn = {
      url = "github:eranknafo2001/WiVRn/fix/on-v25.12";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nur,
    extra-nix-packages,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        extra-nix-packages.overlays.${system}.default
        nur.overlays.default
      ];
    };
    # pkgs = nixpkgs.legacyPackages.${system}.extend extra-nix-packages.overlays.${system}.default;
    lib = nixpkgs.lib.extend (_final: _prev: (import ./lib/default.nix {inherit pkgs;}));
    libHomeManager = lib.extend (_final: _prev: home-manager.lib);
  in {
    nixosConfigurations = {
      eranpc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs lib;};
        modules = [./my-config-structure.nix nur.modules.nixos.default ./systems/eranpc/configuration.nix ./systems/eranpc/my-conf.nix ./systems/common-conf.nix];
      };
      eranlaptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs lib;};
        modules = [./my-config-structure.nix nur.modules.nixos.default ./systems/eranlaptop/configuration.nix ./systems/eranlaptop/my-conf.nix ./systems/common-conf.nix];
      };
    };

    homeConfigurations = {
      "eran@eranpc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit system inputs;
          lib = libHomeManager;
        };
        modules = [./my-config-structure.nix ./systems/eranpc/my-conf.nix ./modules/home/eran/default.nix ./systems/common-conf.nix];
      };
      "eran@eranlaptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit system inputs;
          lib = libHomeManager;
        };
        modules = [./my-config-structure.nix ./systems/eranlaptop/my-conf.nix ./modules/home/eran/default.nix ./systems/common-conf.nix];
      };
    };
  };
}
