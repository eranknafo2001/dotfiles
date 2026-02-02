# Stylix theming
{inputs, ...}: {
  homeModules = [
    inputs.stylix.homeModules.stylix
    # Common stylix configuration
    ({pkgs, ...}: {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        polarity = "dark";
        image = pkgs.fetchurl {
          url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
          sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
        };
      };
    })
    # User-specific stylix configuration
    ({pkgs, lib, ...}: {
      # CJK (Chinese, Japanese, Korean) font support
      home.packages = with pkgs; [
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
      ];

      # Enable fontconfig for proper font fallback
      fonts.fontconfig.enable = true;

      stylix = {
        targets = {
          hyprpaper.enable = lib.mkForce false;
          hyprlock.enable = lib.mkForce false;
          vim.enable = false;
          zed.enable = false;
          vscode.profileNames = ["default"];
        };
        opacity = {terminal = 0.8;};
        fonts = {
          monospace = {
            name = "Hack Nerd Font";
            package = pkgs.nerd-fonts.hack;
          };
        };
      };
    })
  ];
}
