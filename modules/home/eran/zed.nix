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
      ];
      userSettings = {
        vim_mode = true;
        auto_update = false;
        terminal = {
          copy_on_select = false;
          shell.program = "fish";
          toolbar.title = true;
          working_directory = "current_project_directory";
        };
        lsp = {
          nixd.binary.path = "${pkgs.nixd}/bin/nixd";
          nil.binary.path = "${pkgs.nil}/bin/nil";
        };
        languages = {
          Nix.formatter.external.command = "${pkgs.alejandra}/bin/alejandra";
        };
        load_direnv = "shell_hook";
        show_whitespaces = "selection";
        agent = {
          always_allow_tool_actions = true;
          default_model = {
            provider = "openrouter";
            # model = "openai/gpt-5";
            model = "anthropic/claude-sonnet-4";
          };
        };
      };
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
