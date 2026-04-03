{...}: {
  flake.homeModules.stylix = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    imports = [inputs.stylix.homeModules.stylix];

    home.packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      polarity = "dark";
      image = pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
        sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
      };
      targets = {
        hyprpaper.enable = lib.mkForce false;
        hyprlock.enable = lib.mkForce false;
        vim.enable = false;
        zed.enable = false;
        vscode.profileNames = ["default"];
      };
      opacity.terminal = 0.8;
      fonts.monospace = {
        name = "Hack Nerd Font";
        package = pkgs.nerd-fonts.hack;
      };
    };
  };
}
