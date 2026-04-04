{
  description = "Eran Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    # nixpkgs-new.url = "github:nixos/nixpkgs/nixos-unstable";

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

    # nix-gaming.url = "github:fufexan/nix-gaming";
    # nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./flake-modules);
}
