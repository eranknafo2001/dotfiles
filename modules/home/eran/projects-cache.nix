{
  pkgs,
  system,
  ...
}: let
  pin-flakes = pkgs.writers.writeFishBin "pin-flakes" ''
    set projects $HOME/projects
    if test (count $argv) -ge 1
      set projects $argv[1]
    end

    set profile $HOME/.nix/profiles/projects

    nix profile list --profile $profile --json | jq '.elements | keys | .[]' -r | xargs -r nix profile remove --profile $profile

    for d in $projects/*
      if test -f $d/flake.nix
        set ref "$d#devShells.${system}.default"
        echo "Installing $ref …"
        nix profile install --profile $profile $ref
      end
    end
    nix profile wipe-history --profile $profile
  '';
in {
  home.packages = [pin-flakes];
}
