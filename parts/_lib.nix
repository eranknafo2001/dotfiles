# Dendritic Pattern infrastructure
# Defines options for collecting NixOS and Home Manager modules from feature files
{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  system = "x86_64-linux";

  # Create pkgs with all overlays applied
  mkPkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.extra-nix-packages.overlays.${system}.default
      inputs.nur.overlays.default
    ];
  };

  # Extend lib with custom functions (mkSecretWrapper, etc.)
  mkExtendedLib = inputs.nixpkgs.lib.extend (_final: _prev:
    import ../lib/default.nix {pkgs = mkPkgs;});

  # Extend lib with home-manager lib functions
  mkExtendedLibHm = mkExtendedLib.extend (_final: _prev: inputs.home-manager.lib);

  # Helper to create NixOS configuration for a host
  mkNixosConfiguration = {
    hostname,
    hardwareConfig,
    myConf,
    extraModules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        lib = mkExtendedLib;
      };
      modules =
        [
          # Option definitions
          ../my-config-structure.nix

          # NUR
          inputs.nur.modules.nixos.default

          # Hardware
          hardwareConfig

          # Host values
          myConf

          # Common values
          ../systems/common-conf.nix

          # Set hostname
          {networking.hostName = hostname;}
        ]
        # Collected NixOS modules from all feature files
        ++ config.nixosModules
        # Per-host modules
        ++ (config.nixosModulesFor.${hostname} or [])
        # Extra modules passed directly
        ++ extraModules;
    };

  # Helper to create Home Manager configuration
  mkHomeConfiguration = {
    username,
    hostname,
    myConf,
    extraModules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs;
      extraSpecialArgs = {
        inherit system inputs;
        lib = mkExtendedLibHm;
      };
      modules =
        [
          # Option definitions
          ../my-config-structure.nix

          # Host values
          myConf

          # Common values
          ../systems/common-conf.nix

          # User base config
          ({...}: {
            home = {
              username = username;
              homeDirectory = "/home/${username}";
              stateVersion = "24.05";
            };
            programs.home-manager.enable = true;
          })
        ]
        # Collected Home Manager modules from all feature files
        ++ config.homeModules
        # Per-host home modules
        ++ (config.homeModulesFor."${username}@${hostname}" or [])
        # Extra modules passed directly
        ++ extraModules;
    };
in {
  # Define options for collecting modules from feature files
  options = {
    # NixOS modules contributed by feature files
    nixosModules = mkOption {
      type = types.listOf types.deferredModule;
      default = [];
      description = "NixOS modules collected from all feature files";
    };

    # Per-host NixOS modules
    nixosModulesFor = mkOption {
      type = types.attrsOf (types.listOf types.deferredModule);
      default = {};
      description = "NixOS modules for specific hosts";
    };

    # Home Manager modules contributed by feature files
    homeModules = mkOption {
      type = types.listOf types.deferredModule;
      default = [];
      description = "Home Manager modules collected from all feature files";
    };

    # Per-user@host Home Manager modules
    homeModulesFor = mkOption {
      type = types.attrsOf (types.listOf types.deferredModule);
      default = {};
      description = "Home Manager modules for specific user@host combinations";
    };
  };

  # Export helpers as module args
  _module.args = {
    inherit mkPkgs mkExtendedLib mkExtendedLibHm mkNixosConfiguration mkHomeConfiguration;
    defaultSystem = system;
  };
}
