{...}: {
  flake.nixosModules.vr =
    {
      pkgs,
      inputs,
      ...
    }: {
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
          package = inputs.wivrn.packages.${pkgs.system}.default;
        };
        monado = {
          enable = true;
          defaultRuntime = true;
        };
      };
    
      environment.systemPackages = with pkgs; [
        bs-manager
      ];
    }
;
}
