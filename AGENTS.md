# AGENTS.md - NixOS Dotfiles

## Build Commands
```bash
nh os switch /home/eran/dotfiles    # Build & switch NixOS config
nh home switch /home/eran/dotfiles  # Build & switch Home Manager config
nix flake check                      # Validate flake
nix flake update                     # Update inputs
```

**IMPORTANT:** Never run `nh os switch` or `nh home switch` - let the user do it manually.
To test builds without switching, use the `-q` flag (quiet mode) to suppress the interactive UI:
```bash
nh home build -q /home/eran/dotfiles  # Test Home Manager build
nh os build -q /home/eran/dotfiles    # Test NixOS build
```
The `-q` flag is required because the normal output is too long and only errors matter for validation.
After building, delete the `result` symlink to avoid bloating the project.

## Code Style
- **Indentation**: 2 spaces
- **Filenames**: kebab-case (`claude-code.nix`)
- **Variables**: camelCase (`cfg`, `changeWallpaperService`)
- **Custom options**: `my.*` prefix (`my.gaming.enable`)
- **Imports**: Relative paths (`./file.nix`, `../../secrets.yaml`)

## Module Patterns
```nix
{ pkgs, lib, config, ... }:
let cfg = config.my.feature;
in { config = lib.mkIf cfg.enable { ... }; }
```
- Use `lib.mkIf` for conditional config, `lib.mkEnableOption` for booleans
- Use `with pkgs;` for package lists
- Define types via `lib.mkOption { type = lib.types.X; }`

## Structure
- `systems/<host>/my-conf.nix` - Feature flags per machine
- `modules/system/` - NixOS modules, `modules/home/eran/` - Home Manager
- `lib/mkSecretWrapper.nix` - Inject secrets into packages via SOPS

## Configuration Options (`my-config-structure.nix`)
All `my.*` option definitions are centralized in `my-config-structure.nix`. This file:
- Defines all available `my.*` options using `lib.mkEnableOption` or `lib.mkOption`
- Is imported by both NixOS and Home Manager configurations
- Does NOT contain option values - only option declarations

When adding a new feature:
1. Add the option definition to `my-config-structure.nix` (e.g., `my.feature.enable = lib.mkEnableOption "feature";`)
2. Create the module in `modules/system/` or `modules/home/eran/` that uses `config.my.feature`
3. Import the module in the respective `default.nix`
4. Set the option value in `systems/<host>/my-conf.nix` (e.g., `my.feature.enable = true;`)
