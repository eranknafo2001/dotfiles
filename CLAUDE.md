# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
nh os switch /home/eran/dotfiles    # Build & switch NixOS config
nh home switch /home/eran/dotfiles  # Build & switch Home Manager config
nix flake check                      # Validate flake
nix flake update                     # Update inputs
```

**Testing builds without switching** (use `-q` for quiet mode, required for non-interactive output):
```bash
nh home build -q /home/eran/dotfiles  # Test Home Manager build
nh os build -q /home/eran/dotfiles    # Test NixOS build
```
Delete the `result` symlink after building to avoid bloating the project.

**Never run `nh os switch` or `nh home switch` - let the user do it manually.**

## Architecture

This is a NixOS/Home Manager flake with two hosts: `eranpc` (desktop) and `eranlaptop` (laptop).

### Key Files
- `flake.nix` - flake inputs and `flake-parts` bootstrap
- `flake-modules/` - flake-parts modules that define outputs
- `hosts/<host>/` - host configuration, hardware, and profile values

### Module Locations
- `modules/system/` - reusable NixOS implementation modules
- `modules/home/eran/` - reusable Home Manager implementation modules
- `lib/mkSecretWrapper.nix` - utility to inject SOPS secrets into packages

### Adding a New Feature
1. Create or update the implementation module in `modules/system/` or `modules/home/eran/`
2. Export it from `flake-modules/nixos-modules.nix` or `flake-modules/home-modules.nix`
3. Import the named module in the relevant host composition
4. If the feature needs parameters, add them in `hosts/<host>/profile.nix` or `hosts/<host>/home-profile.nix`

## Code Style
- **Indentation**: 2 spaces
- **Filenames**: kebab-case (`claude-code.nix`)
- **Variables**: camelCase (`cfg`, `changeWallpaperService`)
- **Imports**: Relative paths (`./file.nix`)

## Module Pattern
Pure features should be enabled by importing the module, not by an `enable` boolean.

```nix
{ ... }: {
  services.tailscale.enable = true;
}
```

Parameterized modules may define local options when needed:

```nix
{ lib, config, ... }:
let cfg = config.my.hyprland;
in {
  options.my.hyprland.monitors = lib.mkOption { ...; };
  config = { ... };
}
```

Use `with pkgs;` for package lists and `lib.mkOption` for real parameters.
