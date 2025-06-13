{pkgs}: pkg: secretVars:
pkgs.symlinkJoin {
  name = "${pkg.name}-wrapped";
  paths = [pkg];
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    for bin in $out/bin/*; do
      wrapProgram "$bin" ${builtins.concatStringsSep " " (map (
        secretVar: ''--run 'export ${secretVar.name}="$(cat ${secretVar.path})"' ''
      )
      secretVars)}
    done
  '';
}
