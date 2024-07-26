{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.my.hyprland;
in
{
  options.my.hyprland = {
    enable = lib.mkEnableOption "hyprland";
    monitors = lib.mkOption {
      type = with lib.types; listOf (submodule {
        options = {
          name = lib.mkOption { type = str; };
          resolution = lib.mkOption { type = str; default = "preferred"; };
          position = lib.mkOption { type = str; default = "auto"; };
          scale = lib.mkOption { type = float; default = 1.0; };
        };
      });
    };
  };

  config = let
    changeWallpaper = pkgs.writeShellScriptBin "changeWallpaper"
        (lib.strings.concatMapStringsSep "\n"
          (monitor: "hyprctl hyprpaper wallpaper \"${monitor.name},$(find -L ${./wallpapers} -type f | shuf -n 1)\"")
          cfg.monitors
        );
  in lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = with pkgs; [
      dunst
      libnotify
      changeWallpaper
    ];

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    programs.nm-applet.enable = true;

    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    hardware = {
      opengl.enable = true;
      nvidia.modesetting.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --time --cmd \"Hyprland\"";
          user = "eran";
        };
      };
    };
    home-manager.users.eran = { config, pkgs, ... }:
      {
        services.hyprpaper = {
          enable = true;
          settings = {
            ipc = true;
            preload = builtins.map (name: "${./wallpapers}/${name}") (builtins.attrNames (builtins.readDir ./wallpapers));
          };
        };
        programs.waybar = {
          enable = true;
          settings = {
            mainBar = {
              height = 24;
              modules-left = ["hyprland/workspaces" "custom/media"];
              modules-center = ["hyprland/window"];
              modules-right = ["idle_inhibitor" "temperature" "cpu" "memory" "pulseaudio" "backlight" "keyboard-state" "tray" "clock"];
              "hyprland/workspaces" = {
                all-outputs = true;
              };
              "hyprland/window" = {
                separate-outputs = true;
              };
              keyboard-state = {
                numlock = true;
                capslock = true;
                format = "{name} {icon}";
                format-icons = {
                  locked = "";
                  unlocked = "";
                };
              };
              idle_inhibitor = {
                format = "{icon}";
                format-icons = {
                  activated = "";
                  deactivated = "";
                };
              };
              tray = {
                spacing = 10;
              };
              clock = {
                tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                format = "{:L%Y-%m-%d<small>[%a]</small> <tt><small>%p</small></tt>%I:%M}";
              };
              cpu = {
                format = "  {usage}%";
              };
              memory = {
                format = "  {}%";
              };
              temperature = {
                thermal-zone = 2;
                hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
                critical-threshold = 80;
                format-critical = "{icon} {temperatureC}°C";
                format = "{icon} {temperatureC}°C";
                format-icons = ["" "" ""];
              };
              backlight = {
                format = "{icon} {percent}%";
                format-icons = ["" "" "" "" "" "" "" "" ""];
              };
              # network = {
              #   format-wifi = "{essid} ({signalStrength}%) ";
              #   format-ethernet = " {ifname}";
              #   tooltip-format = " {ifname} via {gwaddr}";
              #   format-linked = " {ifname} (No IP)";
              #   format-disconnected = "Disconnected ⚠ {ifname}";
              #   format-alt = " {ifname}: {ipaddr}/{cidr}";
              # };
              pulseaudio = {
                scroll-step = 5;
                format = "{icon}   {volume}% {format_source}";
                format-bluetooth = " {icon}   {volume}% {format_source}";
                format-bluetooth-muted = "  {icon} {format_source}";
                format-muted = "  {format_source}";
                format-source = " {volume}%";
                format-source-muted = "";
                format-icons = {
                  default = ["" "" ""];
                };
                on-click = "pavucontrol";
                on-click-right = "foot -a pw-top pw-top";
              };
              "custom/media" = {
                format = "{icon} {}";
                return-type = "json";
                max-length = 40;
                format-icons = {
                  spotify = "";
                  default = "🎜";
                };
                escape = true;
                exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; 
              };
            };
          };
          style = ''
* {
    border: none;
    border-radius: 4px;
    /* `ttf-font-awesome` is required to be installed for icons */
    font-family: "Roboto Mono Medium", Helvetica, Arial, sans-serif;

    /* adjust font-size value to your liking: */
    font-size: 10px;

    min-height: 0;
}

window#waybar {
    background-color: rgba(0, 0, 0, 0.9);
    /* border-bottom: 3px solid rgba(100, 114, 125, 0.5); */
    color: #ffffff;
    /* transition-property: background-color; */
    /* transition-duration: .5s; */
    /* border-radius: 0; */
}

/* window#waybar.hidden {
    opacity: 0.2;
} */

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

/* window#waybar.termite {
    background-color: #000000;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
} */

#workspaces button {
    /* padding: 0 0.4em; */
    /* background-color: transparent; */
    color: #ffffff;
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
#workspaces button:hover {
    background: rgba(0, 0, 0, 0.9);
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.focused {
    background-color: #64727D;
    /* box-shadow: inset 0 -3px #ffffff; */
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    /* border-bottom: 3px solid #ffffff; */
}

#clock,
#battery,
#cpu,
#memory,
#temperature,
#backlight,
#network,
#pulseaudio,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#mpd {
    padding: 0 10px;
    margin: 6px 3px; 
    color: #000000;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #000000;
    color: white;
}

#battery {
    background-color: #000000;
    color: white;
}

#battery.charging {
    color: #ffffff;
    background-color: #000000;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: #000000;
    color: #ffffff;
}

#memory {
    background-color: #000000;
    color: white;
}

#backlight {
    background-color: #000000;
    color:white;
}

#network {
    background-color: #000000;
    color:white;

}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
    background-color: #000000;
    color: #ffffff;
}

#pulseaudio.muted {
    background-color: #000000;
    color: #ffffff;
}

#custom-media {
    background-color: #66cc99;
    color: #2a5c45;
    min-width: 100px;
}

#custom-media.custom-spotify {
    background-color: #66cc99;
}

#custom-media.custom-vlc {
    background-color: #ffa000;
}

#temperature {
    background-color: #f0932b;
}

#temperature.critical {
    background-color: #eb4d4b;
}

#tray {
    background-color: #2980b9;
}

#idle_inhibitor {
    background-color: #2d3436;
}

#idle_inhibitor.activated {
    background-color: #ecf0f1;
    color: #2d3436;
}

#mpd {
    background-color: #66cc99;
    color: #2a5c45;
}

#mpd.disconnected {
    background-color: #f53c3c;
}

#mpd.stopped {
    background-color: #90b1b1;
}

#mpd.paused {
    background-color: #51a37a;
}

#language {
    background: #bbccdd;
    color: #333333;
    padding: 0 5px;
    margin: 6px 3px;
    min-width: 16px;
}
          '';
        };
        programs.hyprlock = {
            enable = true;
            package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
            settings = let 
              text_color = "rgba(FFFFFFFF)";
              entry_background_color = "rgba(33333311)";
              entry_border_color = "rgba(3B3B3B55)";
              entry_color = "rgba(FFFFFFFF)";
              font_family = "Rubik Light";
              font_family_clock = "Rubik Light";
              font_material_symbols = "Material Symbols Rounded";
            in {
              general = {
                ignore_empty_input = true;
              };
              background = {
                color = "rgba(000000FF)";
              };
              input-field = {
                monitor = "";
                size = "250, 50";
                outline_thickness = 2;
                dots_size = 0.1;
                dots_spacing = 0.3;
                outer_color = entry_border_color;
                inner_color = entry_background_color;
                font_color = entry_color;
                position = "0, 20";
                halign = "center";
                valign = "center";
              };
              label = [
                { # Clock
                  monitor = "";
                  text = "$TIME";
                  shadow_passes = 1;
                  shadow_boost = 0.5;
                  color = text_color;
                  font_size = 65;
                  font_family = font_family_clock;
                  position = "0, 300";
                  halign = "center";
                  valign = "center";
                }
                { # Greeting
                    monitor = "";
                    text = "hi $USER !!!";
                    shadow_passes = 1;
                    shadow_boost = 0.5;
                    color = text_color;
                    font_size = 20;
                    font_family = font_family;
                    position = "0, 240";
                    halign = "center";
                    valign = "center";
                }
                { # lock icon
                    monitor = "";
                    text = "lock";
                    shadow_passes = 1;
                    shadow_boost = 0.5;
                    color = text_color;
                    font_size = 21;
                    font_family = font_material_symbols;
                    position = "0, 65";
                    halign = "center";
                    valign = "bottom";
                }
                { # "locked" text
                  monitor = "";
                  text = "locked";
                  shadow_passes = 1;
                  shadow_boost = 0.5;
                  color = text_color;
                  font_size = 14;
                  font_family = font_family;
                  position = "0, 45";
                  halign = "center";
                  valign = "bottom";
                }
              ];
            };
          };
        services.hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "pidof hyprlock || hyprlock";
              before_sleep_cmd = "loginctl lock-session";
            };
            listener = [
              {
                timeout = 3 * 60;
                on-timeout = "loginctl lock-session";
              }
              {
                timeout = 4 * 60;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
              # {
              #   timeout = 9 * 60;
              #   on-timeout = "pidof steam || systemctl suspend || loginctl suspend";
              # }
            ];
          };
        };
        wayland.windowManager.hyprland = {
          enable = true;
          xwayland.enable = true;
          package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          settings = {
            exec-once = let
              changeWallpaperService = pkgs.writeShellScriptBin "changeWallpaperService" ''
                while true; do
                  ${changeWallpaper}/bin/changeWallpaper
                  sleep ${toString (60 * 5)}
                done
                '';
            in [
              "${changeWallpaperService}/bin/changeWallpaperService"
              "${pkgs.waybar}/bin/waybar"
            ];
            env = [
              "XCURSOR_SIZE,24"
              "HYPRCURSOR_SIZE,24"
            ];
            general = {
              gaps_in = 5;
              gaps_out = 10;
              border_size = 2;
              "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
              "col.inactive_border" = "rgba(595959aa)";
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
              "col.shadow" = "rgba(1a1a1aee)";

              blur = {
                enabled = true;
                size = 3;
                passes = 1;

                vibrancy = 0.1696;
              };
            };
            monitor = builtins.map (monitor: with monitor; "${name},${resolution},${position},${toString scale}") cfg.monitors;
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
            master =  {
              new_status = "master";
            };
            misc = { 
              # force_default_wallpaper = -1;
              # disable_hyprland_logo = false;
            };
            input = {
              kb_layout = "us";
              kb_variant = "";
              kb_model = "";
              kb_options = "";
              kb_rules = "";

              follow_mouse = 1;

              sensitivity = 0;

              touchpad = {
                natural_scroll = false;
              };
            };
            gestures = {
              workspace_swipe = false;
            };
            workspace = lib.lists.imap1 (i: monitor: "${toString i}, monitor:${monitor.name}, default:true") cfg.monitors;
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
            bindm = [
              # Move/resize windows with mainMod + LMB/RMB and dragging
              "$mod, mouse:272, movewindow"
              "$mod, mouse:273, resizewindow"
            ];
            windowrulev2 = "suppressevent maximize, class:.*";
          };
        };
      };
  };
}
