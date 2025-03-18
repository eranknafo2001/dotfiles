{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions;
      []
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "jitpcb-vscode";
          publisher = "jitx";
          version = "3.29.0";
          sha256 = "ZBx/cNb9cUrWzW7oDBTcYHpi+hVuvn6+p4gbUsLiWiQ=";
        }
      ];
  };
}
