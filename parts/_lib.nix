# Shared utilities for creating configurations
# This module provides helper functions used by host and home modules
{inputs, lib, ...}: let
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
          ../my-config-structure.nix
          inputs.nur.modules.nixos.default
          hardwareConfig
          myConf
          ../systems/common-conf.nix
          ../modules/system/default.nix
          {networking.hostName = hostname;}
        ]
        ++ extraModules;
    };

  # Helper to create Home Manager configuration
  mkHomeConfiguration = {
    username,
    hostname,
    myConf,
    homeModules,
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
          ../my-config-structure.nix
          myConf
          ../systems/common-conf.nix
          homeModules
        ]
        ++ extraModules;
    };
in {
  # Export these as flake-parts module args for use by other modules
  _module.args = {
    inherit mkPkgs mkExtendedLib mkExtendedLibHm mkNixosConfiguration mkHomeConfiguration;
    defaultSystem = system;
  };
}
