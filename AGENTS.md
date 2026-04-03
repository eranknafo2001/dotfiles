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
- **Imports**: Relative paths (`./file.nix`, `../../secrets.yaml`)

## Module Patterns
Prefer import-based composition over feature booleans.

### Pure feature module
```nix
{ ... }: {
  services.tailscale.enable = true;
}
```

### Parameterized module
```nix
{ lib, config, ... }:
let cfg = config.my.hyprland;
in {
  options.my.hyprland.monitors = lib.mkOption { ...; };
  config = { ... };
}
```

- If a feature does not need parameters, do not define an `enable` option
- If a feature needs parameters, define only the specific local options it needs
- Use `with pkgs;` for package lists
- Define types via `lib.mkOption { type = lib.types.X; }`

## Structure
- `flake-modules/` - flake-parts modules and flake outputs
- `hosts/<host>/` - host configuration, hardware, and profile values
- `modules/system/` - reusable NixOS implementation modules
- `modules/home/eran/` - reusable Home Manager implementation modules
- `lib/mkSecretWrapper.nix` - inject secrets into packages via SOPS

When adding a new feature:
1. Create or update the implementation module in `modules/system/` or `modules/home/eran/`
2. Export it from `flake-modules/nixos-modules.nix` or `flake-modules/home-modules.nix`
3. Import the named module in the relevant host composition
4. If needed, add host-specific parameter values in `hosts/<host>/profile.nix` or `hosts/<host>/home-profile.nix`
