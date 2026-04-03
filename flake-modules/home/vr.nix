{...}: {
  flake.homeModules.vr =
    {
      pkgs,
      config,
      inputs,
      ...
    }: {
      xdg.configFile."openxr/1/active_runtime.json".source = "${inputs.wivrn.packages.${pkgs.system}.default}/share/openxr/1/openxr_wivrn.json";
    
      xdg.configFile."openvr/openvrpaths.vrpath".text = let
        steam = "${config.xdg.dataHome}/Steam";
      in builtins.toJSON {
        version = 1;
        jsonid = "vrpathreg";
        external_drivers = null;
        config = ["${steam}/config"];
        log = ["${steam}/logs"];
        runtime = [
          "${pkgs.xrizer}/lib/xrizer"
        ];
      };
    }
;
}
