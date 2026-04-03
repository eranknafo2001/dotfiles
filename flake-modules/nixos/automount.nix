{...}: {
  flake.nixosModules.automount =
    {pkgs, ...}: {
      services.udisks2.enable = true;
      environment.systemPackages = with pkgs; [
        ntfs3g
        exfatprogs
      ];
    }
;
}
