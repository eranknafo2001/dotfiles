{pkgs, ...}: {
  home.packages = with pkgs; [xsel wget tmux file curl dust tokei wl-clipboard];
  xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
  services.pueue.enable = true;
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        alias cat=bat
      '';
    };
    bash.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    yazi.enable = true;
    fd.enable = true;
    feh.enable = true;
    jq.enable = true;
    zoxide.enable = true;
    ripgrep.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch];
    };
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      settings = {
        format =
          "[░▒▓](#a3aed2)"
          + "[ ❄️](bg:#a3aed2 fg:#090c0c)"
          + "[](bg:#769ff0 fg:#a3aed2)"
          + "$directory"
          + "[](fg:#769ff0 bg:#394260)"
          + "$git_branch"
          + "$git_status"
          + "[](fg:#394260 bg:#212736)"
          + "$nodejs"
          + "$rust"
          + "$golang"
          + "$php"
          + "$nix_shell"
          + "[](fg:#212736 bg:#1d2230)"
          + "\n$character";

        directory = {
          style = "fg:#e3e5e5 bg:#769ff0";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:#394260";
          format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
        };

        git_status = {
          style = "bg:#394260";
          format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };

        golang = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };

        php = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };

        nix_shell = {
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:#1d2230";
          format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
        };
      };
    };
    nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
