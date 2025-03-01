{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
    # image = ./../home/eran/hyprland/hyprpaper/wallpapers/1356243.png;
    image = pkgs.fetchurl {
      url =
        "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    };
    # wallpaper = ./../home/eran/hyprland/hyprpaper/wallpapers/1356243.png;
    opacity = { terminal = 0.8; };
    fonts = {
      monospace = {
        name = "Hack Nerd Font";
        package = pkgs.nerd-fonts.hack;
      };
    };
  };
}
