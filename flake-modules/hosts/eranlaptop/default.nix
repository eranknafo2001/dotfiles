{self, inputs, ...}: let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
      inputs.extra-nix-packages.overlays.${system}.default
      inputs.nur.overlays.default
    ];
  };
  lib = inputs.nixpkgs.lib.extend (_final: _prev: (import ../../../lib/default.nix {inherit pkgs;}));
  libHomeManager = lib.extend (_final: _prev: inputs.home-manager.lib);
  nixosInputs = inputs // {
    llm-agents.packages = inputs.llm-agents.packages;
    self = {inherit lib;};
  };
  homeInputs = inputs // {
    llm-agents.packages = inputs.llm-agents.packages;
    self.lib = libHomeManager;
  };
in {
  flake.nixosConfigurations.eranlaptop = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit self system lib;
      inputs = nixosInputs;
    };
    modules = [
      self.nixosModules.eranlaptop-configuration
      self.nixosModules.common
      self.nixosModules.user
      self.nixosModules.hyprland
      self.nixosModules.docker
      self.nixosModules.mpd
      self.nixosModules.tailscale
      self.nixosModules.sshd
      self.nixosModules.sops
      self.nixosModules.nix-ld
      self.nixosModules.automount
      self.nixosModules.laptop
      self.nixosModules.hibernation
      self.nixosModules.bluetooth
      self.nixosModules.kde-connect
      self.nixosModules.adb
      self.nixosModules.eranlaptop-profile
    ];
  };

  flake.homeConfigurations."eran@eranlaptop" = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      inherit self system;
      inputs = homeInputs;
      lib = libHomeManager;
      packages = self.packages;
    };
    modules = [
      self.homeModules.base
      self.homeModules.apps
      self.homeModules.stylix
      self.homeModules.git
      self.homeModules.ssh
      self.homeModules.tailscale
      self.homeModules.term
      self.homeModules.nixvim
      self.homeModules.shell
      self.homeModules.hyprland
      self.homeModules.firefox
      self.homeModules.ai-claude-code
      self.homeModules.ai-codex
      self.homeModules.ai-gemini
      self.homeModules.ai-opencode
      self.homeModules.ai-pi
      self.homeModules.ai-btca
      self.homeModules.sops
      self.homeModules.helix
      self.homeModules.bevy
      self.homeModules.zed
      self.homeModules.automount
      self.homeModules.eranlaptop-home-profile
    ];
  };
}
