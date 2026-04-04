{...}: {
  flake.homeModules.hyprland = {
    pkgs,
    lib,
    inputs,
    config,
    system,
    ...
  }: let
    cfg = config.my.hyprland;
    waybarModule = {
      config = lib.mkIf (cfg.bar == "waybar") {
        home.packages = with pkgs; [font-awesome];
        programs.waybar = {
          enable = true;
          settings.mainBar = {
            height = 28;
            modules-left = ["hyprland/workspaces" "custom/media"];
            modules-center = ["hyprland/window"];
            modules-right =
              [
                "idle_inhibitor"
                "temperature"
                "cpu"
                "memory"
                "pulseaudio"
                "backlight"
              ]
              ++ (lib.optionals cfg.battery ["upower"])
              ++ [
                "hyprland/language"
                "tray"
                "clock"
              ];
            "hyprland/workspaces".all-outputs = true;
            "hyprland/window".separate-outputs = true;
            backlight = {
              format = "{icon} {percent}%";
              format-icons = ["🔆"];
            };
            upower = lib.mkIf cfg.battery {
              format = " {percentage}";
              icon-size = 10;
            };
            "hyprland/language" = {
              format-en = "Eng";
              format-he = "Heb";
            };
            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
            tray.spacing = 10;
            temperature = {
              thermal-zone = 2;
              hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
              critical-threshold = 80;
              format-critical = "{icon} {temperatureC}°C";
              format = "{icon} {temperatureC}°C";
              format-icons = ["" ""];
            };
            clock = {
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
              format = "{:L%Y-%m-%d<small>[%a]</small> <tt><small>%p</small></tt>%I:%M}";
            };
            cpu.format = "  {usage}%";
            memory.format = "  {}%";
            pulseaudio = {
              scroll-step = 5;
              format = "{icon}   {volume}% {format_source}";
              format-bluetooth = " {icon}   {volume}% {format_source}";
              format-bluetooth-muted = "  {icon} {format_source}";
              format-muted = "  {format_source}";
              format-source = " {volume}%";
              format-source-muted = "";
              format-icons.default = ["" "" ""];
              on-click = "pavucontrol";
              on-click-right = "foot -a pw-top pw-top";
            };
          };
          style = builtins.readFile ../assets/hyprland/waybar-style.css;
        };
      };
    };
    ewwModule = {
      config = lib.mkIf (cfg.bar == "eww") {
        programs.eww = {
          enable = true;
          enableFishIntegration = true;
          configDir = ../assets/hyprland/eww;
        };
      };
    };
    hyprpaperModule = let
      changeWallpaper =
        pkgs.writeShellScriptBin "changeWallpaper"
        (lib.strings.concatMapStringsSep "\n" (monitor: ''
          hyprctl hyprpaper wallpaper "${monitor.name},$(find -L ${../assets/hyprland/wallpapers} -type f | shuf -n 1)"'')
        cfg.monitors);
    in {
      home.packages = [changeWallpaper];
      services.hyprpaper = {
        enable = true;
        package = inputs.hyprpaper.packages.${system}.default;
        settings = {
          ipc = true;
          wallpaper =
            lib.map (monitor: {
              monitor = monitor.name;
              path = "${../assets/hyprland/wallpapers}/1.jpg";
            })
            cfg.monitors;
          preload =
            builtins.map (name: "${../assets/hyprland/wallpapers}/${name}")
            (builtins.attrNames (builtins.readDir ../assets/hyprland/wallpapers));
        };
      };
    };
    hypridleModule = {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
            on_unlock_cmd = lib.mkIf cfg.asus-nmcli-fix "nmcli radio wifi on";
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
            {
              timeout = 9 * 60;
              on-timeout = "pidof steam || systemctl suspend";
            }
          ];
        };
      };
    };
    hyprlockModule = {
      programs.hyprlock = {
        enable = true;
        package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
        settings = let
          text_color = "rgba(FFFFFFFF)";
          discrete_color = "rgba(AAAAAA88)";
          entry_background_color = "rgba(33333311)";
          entry_border_color = "rgba(3B3B3B55)";
          entry_color = "rgba(FFFFFFFF)";
          font_family = "Rubik Light";
          font_family_clock = "Rubik Light";
          font_material_symbols = "Material Symbols Rounded";
        in {
          general.ignore_empty_input = true;
          background.color = "rgba(000000FF)";
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
            {
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
            {
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
            {
              monitor = "";
              text = "$LAYOUT";
              shadow_passes = 1;
              shadow_boost = 0.5;
              color = discrete_color;
              font_size = 12;
              font_family = font_family;
              position = "20, -20";
              halign = "left";
              valign = "top";
            }
            {
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
            {
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
    };
    hyprsunsetModule = {
      services.hyprsunset = {
        enable = true;
        settings = {
          max-gamma = 100;
          profile = [
            {
              time = "7:30";
              identity = true;
            }
            {
              time = "20:00";
              temperature = 3800;
              gamma = 0.9;
            }
          ];
        };
      };
    };
  in {
    imports = [
      waybarModule
      ewwModule
      hyprpaperModule
      hypridleModule
      hyprlockModule
      hyprsunsetModule
    ];

    options.my.hyprland = {
      nvidia = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      battery = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      asus-nmcli-fix = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      bar = lib.mkOption {
        type = lib.types.enum ["waybar" "eww"];
        default = "waybar";
      };
      monitors = lib.mkOption {
        type = with lib.types;
          listOf (submodule {
            options = {
              name = lib.mkOption {type = str;};
              resolution = lib.mkOption {type = str;};
              position = lib.mkOption {type = str;};
              scale = lib.mkOption {type = float;};
            };
          });
        default = [];
      };
    };

    config = {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi;
      };

      fonts.fontconfig.enable = true;
      home.packages = with pkgs; [nerd-fonts.hack bibata-cursors];

      services = {
        avizo = {
          enable = true;
          settings.default.time = 0.5;
        };
        mako = {
          enable = true;
          settings.default-timeout = 5000;
        };
        playerctld.enable = true;
      };

      home.sessionVariables = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
      };

      gtk = {
        enable = true;
        cursorTheme = {
          name = "Bibata-Modern-Ice";
          package = pkgs.bibata-cursors;
          size = 24;
        };
        iconTheme = {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
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
                changeWallpaper
                sleep ${toString (60 * 5)}
              done
            '';
          in
            (lib.optionals (cfg.bar == "waybar") ["${pkgs.waybar}/bin/waybar"])
            ++ [
              "${pkgs.clipse}/bin/clipse -listen"
              "hyprctl setcursor Bibata-Modern-Ice 24"
              "sleep 3 && ${changeWallpaperService}/bin/changeWallpaperService"
            ];
          xwayland.force_zero_scaling = true;
          env = ["XCURSOR_SIZE,24" "HYPRCURSOR_SIZE,24"];
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
            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
            };
            blur = {
              enabled = true;
              size = 3;
              passes = 1;
              vibrancy = 0.1696;
            };
          };
          monitor =
            builtins.map (
              monitor:
                with monitor; "${name},${resolution},${position},${toString scale}"
            )
            cfg.monitors;
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
          master.new_status = "master";
          misc = {};
          input = {
            kb_layout = "us,il";
            kb_variant = "";
            kb_model = "";
            kb_options = "grp:win_space_toggle";
            kb_rules = "";
            follow_mouse = 1;
            sensitivity = 0;
            touchpad = {
              natural_scroll = true;
              tap-to-click = true;
              scroll_factor = 0.8;
            };
          };
          gesture = [
            "3, horizontal, workspace"
            "4, swipe, move"
          ];
          workspace =
            lib.lists.imap1
            (i: monitor: "${toString i}, monitor:${monitor.name}, default:true")
            cfg.monitors;
          "$mod" = "SUPER";
          bind = [
            "$mod, Return, exec, ${pkgs.ghostty}/bin/ghostty"
            "$mod SHIFT, C, killactive,"
            "$mod SHIFT, X, exit,"
            "$mod, E, exec, $fileManager"
            "$mod, F, fullscreen,2"
            "$mod, G, fullscreen,1"
            "$mod SHIFT, F, togglefloating,"
            "$mod, R, exec, ${pkgs.rofi}/bin/rofi -show drun"
            "$mod, escape, exec, hyprlock"
            "$mod, P, pseudo,"
            "$mod, M, togglesplit,"
            "$mod, L, movefocus, r"
            "$mod, H, movefocus, l"
            "$mod, K, movefocus, u"
            "$mod, J, movefocus, d"
            "$mod SHIFT, L, movewindow, r"
            "$mod SHIFT, H, movewindow, l"
            "$mod SHIFT, K, movewindow, u"
            "$mod SHIFT, J, movewindow, d"
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
            "$mod, S, togglespecialworkspace, magic"
            "$mod SHIFT, S, movetoworkspace, special:magic"
            "$mod, V, exec, ${pkgs.ghostty}/bin/ghostty --class=\"ghostty.clipse\" --background-opacity=1 -e ${pkgs.clipse}/bin/clipse"
            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"
            '', Print, exec, mkdir -p ~/Pictures/Screenshots && F=~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png && ${pkgs.grim}/bin/grim $F && ${pkgs.wl-clipboard}/bin/wl-copy < $F''
            ''SHIFT, Print, exec, mkdir -p ~/Pictures/Screenshots && F=~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" $F && ${pkgs.wl-clipboard}/bin/wl-copy < $F''
            ''CTRL, Print, exec, mkdir -p ~/Pictures/Screenshots && F=~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png && ${pkgs.grim}/bin/grim $F && echo -n $F | ${pkgs.wl-clipboard}/bin/wl-copy''
            ''CTRL SHIFT, Print, exec, mkdir -p ~/Pictures/Screenshots && F=~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" $F && echo -n $F | ${pkgs.wl-clipboard}/bin/wl-copy''
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
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "float,class:ghostty.clipse"
            "size 622 652,class:ghostty.clipse"
          ];
        };
      };
    };
  };
}
