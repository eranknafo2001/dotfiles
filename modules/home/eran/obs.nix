{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.my.obs;
in {
  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;

      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vkcapture
      ];
    };
  };
}
