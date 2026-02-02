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

This is a NixOS/Home Manager flake using **flake-parts** with the **Dendritic Pattern**. Every Nix file in `parts/` is a flake-parts module that contributes to the configuration. It manages two hosts: `eranpc` (desktop) and `eranlaptop` (laptop).

### Flake Structure (Dendritic Pattern)

The flake uses `flake-parts` and `import-tree` for automatic module discovery. All files in `parts/` are auto-imported:

```
flake.nix                    # Minimal entry point using flake-parts
parts/                       # All flake-parts modules (auto-imported)
├── _base.nix               # Base configuration (systems)
├── _lib.nix                # Defines nixosModules/homeModules options + helpers
├── nixos/                  # NixOS feature modules (contribute to nixosModules)
│   ├── common.nix         # Base packages, locale, nix settings
│   ├── hyprland.nix       # Hyprland window manager
│   ├── docker.nix         # Docker
│   ├── gaming.nix         # Steam, Lutris, Heroic
│   └── ...                # Other NixOS features
├── home/                   # Home Manager feature modules (contribute to homeModules)
│   ├── shell.nix          # Fish, bash, starship, tools
│   ├── zed.nix            # Zed editor with AI
│   ├── hyprland.nix       # Hyprland user config
│   └── ...                # Other home features
└── hosts/                  # Host definitions (define flake outputs)
    ├── eranpc.nix         # NixOS config for desktop
    └── eranlaptop.nix     # NixOS config for laptop
```

### Key Files
- `flake.nix` - Minimal flake using `flake-parts.lib.mkFlake` and `import-tree`
- `parts/_lib.nix` - Defines `nixosModules`/`homeModules` options, helper functions
- `my-config-structure.nix` - Centralized `my.*` option definitions
- `systems/<host>/my-conf.nix` - Feature flags per machine (option values)
- `systems/common-conf.nix` - Shared configuration across hosts

### How the Dendritic Pattern Works

1. **Feature modules** in `parts/nixos/` contribute to `config.nixosModules`
2. **Feature modules** in `parts/home/` contribute to `config.homeModules`
3. **Host modules** in `parts/hosts/` call `mkNixosConfiguration` which:
   - Imports all collected `nixosModules`
   - Adds host-specific hardware and settings
4. **Home modules** call `mkHomeConfiguration` which:
   - Imports all collected `homeModules`
   - Adds user-specific settings

### Adding a New NixOS Feature

Create a file in `parts/nixos/`:
```nix
# parts/nixos/my-feature.nix
{...}: {
  nixosModules = [
    ({lib, config, ...}: let
      cfg = config.my.feature;
    in {
      config = lib.mkIf cfg.enable {
        # NixOS configuration here
      };
    })
  ];
}
```

### Adding a New Home Manager Feature

Create a file in `parts/home/`:
```nix
# parts/home/my-feature.nix
{...}: {
  homeModules = [
    ({lib, config, pkgs, ...}: let
      cfg = config.my.feature;
    in {
      config = lib.mkIf cfg.enable {
        # Home Manager configuration here
      };
    })
  ];
}
```

### Adding a New Host

1. Create `parts/hosts/<hostname>.nix` using `mkNixosConfiguration`
2. Create `parts/home/<user>-<hostname>.nix` using `mkHomeConfiguration`
3. Create `systems/<hostname>/hardware-configuration.nix`
4. Create `systems/<hostname>/my-conf.nix` with feature flags

## Code Style
- **Indentation**: 2 spaces
- **Filenames**: kebab-case (`claude-code.nix`)
- **Variables**: camelCase (`cfg`, `changeWallpaperService`)
- **Custom options**: `my.*` prefix (`my.gaming.enable`)
- **Imports**: Relative paths (`./file.nix`)

## Module Patterns

### NixOS/Home Manager Module (in parts/nixos/ or parts/home/)
```nix
{...}: {
  nixosModules = [  # or homeModules for home-manager
    ({lib, config, pkgs, ...}: let
      cfg = config.my.feature;
    in {
      config = lib.mkIf cfg.enable { ... };
    })
  ];
}
```

### Host Definition (in parts/hosts/)
```nix
{mkNixosConfiguration, ...}: {
  flake.nixosConfigurations.hostname = mkNixosConfiguration {
    hostname = "hostname";
    hardwareConfig = ../../systems/hostname/hardware-configuration.nix;
    myConf = ../../systems/hostname/my-conf.nix;
    extraModules = [ /* additional modules */ ];
  };
}
```

Use `lib.mkIf` for conditional config, `lib.mkEnableOption` for booleans, `with pkgs;` for package lists.
