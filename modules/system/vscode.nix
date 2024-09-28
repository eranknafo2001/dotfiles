{ pkgs, lib, config, ... }:
let cfg = config.my.vscode;
in {
  options.my.vscode = { enable = lib.mkEnableOption "vscode"; };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vscode ];
    services.udev.packages = [ pkgs.platformio-core pkgs.openocd ];
  };
}
