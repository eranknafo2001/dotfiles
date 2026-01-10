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
- `flake.nix` - Flake inputs and configuration outputs
- `my-config-structure.nix` - Centralized `my.*` option definitions (declarations only, no values)
- `systems/<host>/my-conf.nix` - Feature flags per machine (option values)
- `systems/common-conf.nix` - Shared configuration across hosts

### Module Locations
- `modules/system/` - NixOS system modules
- `modules/home/eran/` - Home Manager user modules
- `lib/mkSecretWrapper.nix` - Utility to inject SOPS secrets into packages

### Adding a New Feature
1. Add option definition to `my-config-structure.nix` (e.g., `my.feature.enable = lib.mkEnableOption "feature";`)
2. Create module in `modules/system/` or `modules/home/eran/`
3. Import the module in the respective `default.nix`
4. Set option value in `systems/<host>/my-conf.nix` (e.g., `my.feature.enable = true;`)

## Code Style
- **Indentation**: 2 spaces
- **Filenames**: kebab-case (`claude-code.nix`)
- **Variables**: camelCase (`cfg`, `changeWallpaperService`)
- **Custom options**: `my.*` prefix (`my.gaming.enable`)
- **Imports**: Relative paths (`./file.nix`)

## Module Pattern
```nix
{ pkgs, lib, config, ... }:
let cfg = config.my.feature;
in { config = lib.mkIf cfg.enable { ... }; }
```

Use `lib.mkIf` for conditional config, `lib.mkEnableOption` for booleans, `with pkgs;` for package lists.
