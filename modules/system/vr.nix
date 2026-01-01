{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.my.vr;
in {
  config = lib.mkIf cfg.enable {

   programs.steam.package = pkgs.steam.override {
      extraProfile = ''
        # Fixes timezones on VRChat
        unset TZ
        # Allows Monado to be used
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
      '';
    };

    services = {
      wivrn = {
      enable = true;
      openFirewall = true;
      autoStart = true;
      package = inputs.wivrn.packages.${pkgs.system}.default;
      #package = (inputs.wivrn.packages.${pkgs.system}.wivrn.override { cudaSupport = true; });
    };
    monado = {
      enable = true;
      defaultRuntime = true;
    };
    };
    # programs.alvr = {
    #   enable = true;
    #   openFirewall = true;
    # };
    environment.systemPackages = with pkgs; [
      bs-manager
    ];
  };
}
