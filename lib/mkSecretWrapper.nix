{pkgs}: pkg: secretVars:
pkgs.symlinkJoin {
  name = "${pkg.name}-wrapped";
  paths = [pkg];
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    for bin in $out/bin/*; do
      wrapProgram "$bin" ${builtins.concatStringsSep " " (map (
        {
          name,
          path,
        }: ''--run 'export ${name}="$(cat ${path})"' ''
      )
      secretVars)}
    done
  '';
}
