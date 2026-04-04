{...}: {
  flake.nixosModules.vr = {pkgs, ...}: {
    programs.steam.package = pkgs.steam.override {
      extraProfile = ''
        unset TZ
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
      '';
    };

    services = {
      wivrn = {
        enable = true;
        openFirewall = true;
        autoStart = true;
        package = pkgs.wivrn;
      };
      monado = {
        enable = true;
        defaultRuntime = true;
      };
    };

    environment.systemPackages = with pkgs; [
      bs-manager
    ];
  };
}
