{
  lib,
  config,
  ...
}: let
  cfg = config.my.mpd;
in {
  config = lib.mkIf cfg.enable {
    services.mpd = {
      enable = true;
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';
      network.listenAddress = "any";
      startWhenNeeded = true;
    };
  };
}
