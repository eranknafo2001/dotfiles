{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    settings = {
      theme = lib.mkForce "tokyonight";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nil"];
          roots = ["flake.nix"];
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
        }
      ];
      language-server.nil = {
        command = "${pkgs.nil}/bin/nil";
        config.nil.formatting.command = ["${pkgs.alejandra}/bin/alejandra"];
      };
    };
  };
}
