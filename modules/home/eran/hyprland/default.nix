{ pkgs, lib, inputs, my, ... }:
let cfg = my.hyprland;
in {
  imports = [
    ./waybar/default.nix
    ./hyprpaper/default.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;
  services.avizo.enable = true;
  services.mako.enable = true;
  services.playerctld.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      exec-once = let
        changeWallpaperService =
          pkgs.writeShellScriptBin "changeWallpaperService" ''
            while true; do
              changeWallpaper
              sleep ${toString (60 * 5)}
            done
          '';
      in [
        "${changeWallpaperService}/bin/changeWallpaperService"
        "${pkgs.waybar}/bin/waybar"
      ];
      env = [ "XCURSOR_SIZE,24" "HYPRCURSOR_SIZE,24" ];
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };
      monitor = builtins.map (monitor:
        with monitor;
        "${name},${resolution},${position},${toString scale}") cfg.monitors;
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = { new_status = "master"; };
      misc = {
        # force_default_wallpaper = -1;
        # disable_hyprland_logo = false;
      };
      input = {
        kb_layout = "us,il";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = { natural_scroll = false; };
      };
      gestures = { workspace_swipe = false; };
      workspace = lib.lists.imap1
        (i: monitor: "${toString i}, monitor:${monitor.name}, default:true")
        cfg.monitors;
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
        "$mod SHIFT, C, killactive,"
        "$mod SHIFT, X, exit,"
        "$mod, E, exec, $fileManager"
        "$mod, F, fullscreen,2"
        "$mod SHIFT, F, togglefloating,"
        "$mod, R, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
        "$mod, escape, exec, hyprlock"
        "$mod, P, pseudo,"
        "$mod, M, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mod, L, movefocus, r"
        "$mod, H, movefocus, l"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, focusworkspaceoncurrentmonitor, 1"
        "$mod, 2, focusworkspaceoncurrentmonitor, 2"
        "$mod, 3, focusworkspaceoncurrentmonitor, 3"
        "$mod, 4, focusworkspaceoncurrentmonitor, 4"
        "$mod, 5, focusworkspaceoncurrentmonitor, 5"
        "$mod, 6, focusworkspaceoncurrentmonitor, 6"
        "$mod, 7, focusworkspaceoncurrentmonitor, 7"
        "$mod, 8, focusworkspaceoncurrentmonitor, 8"
        "$mod, 9, focusworkspaceoncurrentmonitor, 9"
        "$mod, 0, focusworkspaceoncurrentmonitor, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

      ];
      bindl = [
        ",XF86AudioMicMute, exec, ${pkgs.avizo}/bin/volumectl -m toggle-mute"
        ",XF86AudioMute, exec, ${pkgs.avizo}/bin/volumectl toggle-mute"

        ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, ${pkgs.avizo}/bin/volumectl -u up"
        ",XF86AudioLowerVolume, exec, ${pkgs.avizo}/bin/volumectl -u down"

        ",XF86MonBrightnessUp, exec, ${pkgs.avizo}/bin/lightctl up"
        ",XF86MonBrightnessDown, exec, ${pkgs.avizo}/bin/lightctl down"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      windowrulev2 = "suppressevent maximize, class:.*";
    };
  };
}
