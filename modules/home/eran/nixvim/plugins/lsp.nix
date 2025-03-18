{ config, pkgs, ... }: let mkRaw = config.lib.nixvim.mkRaw; in {
  programs.nixvim.plugins = {
    blink-copilot = {
      enable = true;
      autoLoad = true;
    };
    blink-cmp = {
      enable = true;
      autoLoad = true;
      settings = {
        keymap = {
          preset = "enter";
          "<C-k>" = [ "select_prev" "fallback" ];
          "<C-j>" = [ "select_next" "fallback" ];
        };
        sources = {
          providers = {
            copilot = {
              async = true;
              module = "blink-copilot";
              name = "copilot";
              score_offset = 100;
              opts = {
                max_completions = 3;
                max_attempts = 4;
                kind = "Copilot";
                debounce = 750;
                auto_refresh = {
                  backward = true;
                  forward = true;
                };
              };
            };
          };
          default = [ "lsp" "path" "buffer" "copilot" ];
        };
      };
    };
    lsp = {
      enable = true;
      autoLoad = true;
      servers = {
        nil_ls.enable = true;
        nushell.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        ts_ls.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
      };
    };
    conform-nvim = {
      enable = true;
      autoLoad = true;
      settings = {
        formatters_by_ft = {
        rust = mkRaw ''{ "rustfmt", lsp_format = "fallback" }'';
        svelte = mkRaw ''{ "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true }'';
        javascript = mkRaw ''{ "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true }'';
        typescript = mkRaw ''{ "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true }'';
        nix = mkRaw ''{ "alejandra", lsp_format = "fallback" }'';
        };
      notify_on_error = true;
      notify_on_formatters = true;
        log_level = "trace";
      formaters = {
        alejandra = {
          command = "${pkgs.alejandra}/bin/alejandra";
          args = [ "$FILENAME" ];
          stdin = false;
          cwd = mkRaw ''require("conform.util").root_file({ "flake.nix" })'';
        };
        prettier = {
          command = "${pkgs.nodePackages.prettier}/bin/prettier";
        };
        prettierd = {
          command = "${pkgs.prettierd}/bin/prettierd";
        };
        rustfmt = {
          command = "${pkgs.rustfmt}/bin/rustfmt";
        };
      };
      };
    };
    fidget = { 
      enable = true;
      autoLoad = true;
    };
  };
}
