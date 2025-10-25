{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.zed;
  zed-editor = lib.mkSecretWrapper pkgs.zed-editor [
    {
      name = "OPENROUTER_API_KEY";
      inherit (config.sops.secrets.openrouter_key) path;
    }
    {
      name = "OPENAI_API_KEY";
      inherit (config.sops.secrets.openai_key) path;
    }
    {
      name = "ANTHROPIC_API_KEY";
      inherit (config.sops.secrets.anthropic_key) path;
    }
    {
      name = "GEMINI_API_KEY";
      inherit (config.sops.secrets.gemini_key) path;
    }
  ];
in {
  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "html"
        "nix"
        "mcp-server-context7"
        "dockerfile"
        "toml"
        "git-firefly"
        "sql"
        "make"
        "scss"
        "svelte"
        "terraform"
        "lua"
        "elixir"
        "zig"
        "docker-compose"
        "pylsp"
        "ruff"
        "basher"
        "csv"
        "env"
        "ini"
        "deno"
        "tailwind-theme"
        "cargo-tom"
        "fish"
        "just"
        "nginx"
        "ansible"
        "scheme"
        "nu"
        "mermaid"
        "verilog"
        "wgsl"
        "plantuml"
        "ssh-config"
        "gitlab-ci-ls"
        "caddyfile"
        "mcp-server-sequential-thinking"
      ];
      userSettings = {
        vim_mode = true;
        auto_update = false;
        theme = {
          mode = "dark";
          dark = "Tokyo Night";
          light = "Tokyo Night";
        };
        terminal = {
          copy_on_select = false;
          shell.program = "fish";
          # toolbar.title = true;
          working_directory = "current_project_directory";
        };
        lsp = {
          nixd.binary.path = "${pkgs.nixd}/bin/nixd";
          nil.binary.path = "${pkgs.nil}/bin/nil";
          gitlab-ci.binary.path = "${pkgs.gitlab-ci-ls}/bin/gitlab-ci-ls";
          elixir-ls.binary.path = "${pkgs.elixir-ls}/bin/elixir-ls";
        };
        # languages = {
        #   Nix.formatter.external.command = "${pkgs.alejandra}/bin/alejandra";
        # };
        load_direnv = "direct";
        show_whitespaces = "selection";
        # context_servers = {
        #   mcp-server-context7 = {
        #     source = "extension";
        #     enabled = true;
        #   };
        # };
        agent = {
          always_allow_tool_actions = true;
          default_model = {
            provider = "zed.dev";
            model = "claude-sonnet-4-thinking";
          };
        };
        vim = {
          use_smartcase_find = true;
          toggle_relative_line_numbers = true;
          use_system_clipboard = "never";
        };
        command_aliases = {
          "W" = "w";
          "Wq" = "wq";
          "Q" = "q";
        };
      };
      userKeymaps = [
        {
          context = "VimControl || !Editor && !Terminal";
          bindings = {
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-l" = "workspace::ActivatePaneRight";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-j" = "workspace::ActivatePaneDown";
          };
        }
        {
          context = "Dock";
          bindings = {
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-l" = "workspace::ActivatePaneRight";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-j" = "workspace::ActivatePaneDown";
          };
        }
        {
          context = "vim_mode == visual";
          bindings = {
            "s" = ["vim::PushAddSurrounds" {}];
          };
        }
        {
          context = "Editor && vim_mode == normal";
          bindings = {
            "shift-l" = "pane::ActivateNextItem";
            "shift-h" = "pane::ActivatePreviousItem";
            "space e" = "project_panel::ToggleFocus";
            "space P" = ["workspace::SendKeystrokes" "\" + P"];
            "space Y" = ["workspace::SendKeystrokes" "\" + Y"];
          };
        }
        {
          context = "Editor && (vim_mode == visual || vim_mode == visual_line || vim_mode == visual_block || vim_mode == normal)";
          bindings = {
            "space p" = ["workspace::SendKeystrokes" "\" + p"];
            "space y" = ["workspace::SendKeystrokes" "\" + y"];
          };
        }
      ];
      package = zed-editor;
    };

    sops.secrets = {
      openrouter_key = {};
      openai_key = {};
      anthropic_key = {};
      gemini_key = {};
    };
  };
}
