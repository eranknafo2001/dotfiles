{...}: {
  perSystem = {pkgs, ...}: {
    packages.ghostty-eran = let
      ghosttyConfig = pkgs.writeText "ghostty-eran.conf" ''
        command = ${pkgs.fish}/bin/fish
        shell-integration = fish
        background-opacity = 0.9
        background-blur = 20
      '';
    in
      pkgs.writeShellScriptBin "ghostty" ''
        exec ${pkgs.ghostty}/bin/ghostty --config-file ${ghosttyConfig} "$@"
      '';
  };
}
