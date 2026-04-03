{...}: {
  flake.homeModules.automount =
    {...}: {
      services.udiskie = {
        enable = true;
        tray = "never";
        notify = true;
        automount = true;
      };
    }
;
}
