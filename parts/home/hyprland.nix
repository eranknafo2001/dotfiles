# Hyprland Home Manager configuration
# This module references the detailed hyprland config in modules/home/eran/hyprland/
{...}: {
  homeModules = [
    # Import the existing hyprland module structure
    # (it contains waybar, eww, hyprpaper, hypridle, hyprlock, hyprsunset)
    ../../modules/home/eran/hyprland/default.nix
  ];
}
