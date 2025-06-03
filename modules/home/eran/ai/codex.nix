{
  pkgs,
  config,
  ...
}: let
  codex-wrapper = pkgs.writeShellScriptBin "codex" ''
    OPENAI_API_KEY=$(cat ${config.sops.secrets.openai_key.path}) exec ${pkgs.codex-cli}/bin/codex $@
  '';
in {
  home.packages = [codex-wrapper];
  sops.secrets.openai_key = {};
}
