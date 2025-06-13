{pkgs}: {
  mkSecretWrapper = import ./mkSecretWrapper.nix {inherit pkgs;};
}
