# Package-first refactor plan

## Goal
Move configured programs toward a pattern where configuration is packaged into reusable packages, and modules mainly install those packages.

## Principles
1. Migrate one program family at a time.
2. Prefer flake `perSystem.packages` outputs for reusable configured programs.
3. Keep secrets and host-specific values in modules unless they can be safely wrapped.
4. Do not mix large structural refactors with package-first migrations.

## Migration order
1. Low-risk user programs with static config
   - ghostty
   - simple CLI bundles
   - standalone config-driven apps
2. Editor/tooling programs
   - nixvim
   - helix helpers
   - shell tooling bundles
3. AI tools and wrappers
   - claude-code
   - opencode
   - pi
   - codex
4. Desktop/session components
   - hyprland-adjacent helpers
   - bars / launchers / wallpaper helpers

## Recommended shape
- Define configured packages in flake `perSystem.packages`
- Keep Home Manager/NixOS modules thin:
  - install the package
  - wire secrets if needed
  - wire service integration if needed

## First candidate
Start with the terminal family by packaging configured Ghostty and having the Home Manager module install that package.
