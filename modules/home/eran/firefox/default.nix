{ pkgs, config, ... }: {
  programs.firefox = {
    enable = false;
    # profiles.eran = {
    #   # extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ];
    #   settings = { "extensions.autoDisableScopes" = 0; };
    # };
  };
  home.file = {
    ".mozilla/native-messaging-hosts/firefox-webserial" = {
      source = ./firefox-webserial;
      executable = true;
    };
    ".mozilla/native-messaging-hosts/io.github.kuba2k2.webserial.json".text = ''
      {
        "name": "io.github.kuba2k2.webserial",
        "description": "WebSerial for Firefox",
        "path": "${config.home.homeDirectory}/.mozilla/native-messaging-hosts/firefox-webserial",
        "type": "stdio",
        "allowed_extensions": ["webserial@kuba2k2.github.io"]
      }
    '';
  };
}
