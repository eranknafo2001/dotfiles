{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
    image = ./../home/eran/hyprland/hyprpaper/wallpapers/1356243.png;
    opacity = { terminal = 0.8; };
    fonts = {
      monospace = {
        name = "Hack Nerd Font";
        package = (pkgs.nerdfonts.override { fonts = [ "Hack" ]; });
      };
    };
  };
}
