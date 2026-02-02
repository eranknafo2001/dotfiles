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

This is a NixOS/Home Manager flake using **flake-parts** with the **Dendritic Pattern**. It manages two hosts: `eranpc` (desktop) and `eranlaptop` (laptop).

### Flake Structure (Dendritic Pattern)

The flake uses `flake-parts` and `import-tree` for automatic module discovery:

```
flake.nix                    # Minimal entry point using flake-parts
parts/                       # All flake-parts modules (auto-imported)
├── _base.nix               # Base configuration (systems)
├── _lib.nix                # Helper functions for creating configs
├── hosts/                  # NixOS host definitions
│   ├── eranpc.nix         # Desktop configuration
│   └── eranlaptop.nix     # Laptop configuration
└── home/                   # Home Manager configurations
    ├── eran-eranpc.nix    # Home config for eran@eranpc
    └── eran-eranlaptop.nix # Home config for eran@eranlaptop
```

### Key Files
- `flake.nix` - Minimal flake using `flake-parts.lib.mkFlake` and `import-tree`
- `parts/_lib.nix` - Helper functions: `mkNixosConfiguration`, `mkHomeConfiguration`
- `my-config-structure.nix` - Centralized `my.*` option definitions
- `systems/<host>/my-conf.nix` - Feature flags per machine (option values)
- `systems/common-conf.nix` - Shared configuration across hosts

### Module Locations
- `modules/system/` - NixOS system modules
- `modules/home/eran/` - Home Manager user modules
- `lib/mkSecretWrapper.nix` - Utility to inject SOPS secrets into packages

### Adding a New Host
1. Create `parts/hosts/<hostname>.nix` using `mkNixosConfiguration`
2. Create `parts/home/<user>-<hostname>.nix` using `mkHomeConfiguration`
3. Create `systems/<hostname>/hardware-configuration.nix`
4. Create `systems/<hostname>/my-conf.nix` with feature flags

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

## Module Patterns

### NixOS/Home Manager Module
```nix
{ pkgs, lib, config, ... }:
let cfg = config.my.feature;
in { config = lib.mkIf cfg.enable { ... }; }
```

### Flake-Parts Module (in parts/)
```nix
{ inputs, mkNixosConfiguration, ... }: {
  flake.nixosConfigurations.hostname = mkNixosConfiguration {
    hostname = "hostname";
    hardwareConfig = ../../systems/hostname/hardware-configuration.nix;
    myConf = ../../systems/hostname/my-conf.nix;
    extraModules = [ /* additional modules */ ];
  };
}
```

Use `lib.mkIf` for conditional config, `lib.mkEnableOption` for booleans, `with pkgs;` for package lists.
