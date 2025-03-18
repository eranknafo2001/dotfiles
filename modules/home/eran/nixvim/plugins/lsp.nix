{
  config,
  pkgs,
  lib,
  ...
}: let
  helpers = config.lib.nixvim;
  inherit (helpers) mkRaw listToUnkeyedAttrs;
  # inherit (lib) getExe;
in {
  # home.packages = [pkgs.alejandra];
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
          "<C-k>" = ["select_prev" "fallback"];
          "<C-j>" = ["select_next" "fallback"];
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
          default = ["lsp" "path" "buffer" "copilot"];
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
      lazyLoad.settings = {
        cmd = "ConformInfo";
        event = "BufWritePre";
        keys = [
          ((listToUnkeyedAttrs [
              "<leader>cf"
              (mkRaw ''function() require("conform").format() end'')
            ])
            // {
              mode = ["n" "v"];
              desc = "Format";
            })
        ];
      };
      settings = {
        format_on_save = mkRaw ''
          function(bufnr)
            if not (vim.g.autoformat or vim.b[bufnr].autoformat) then
              return
            end

            return { timeout_ms = 500, lsp_format = "fallback" }
          end
        '';
        formatters_by_ft = {
          rust = mkRaw ''{ "rustfmt", lsp_format = "fallback" }'';
          svelte =
            mkRaw ''
              { "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true }'';
          javascript =
            mkRaw ''
              { "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true }'';
          typescript =
            mkRaw ''
              { "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true }'';
          # nix = [ "nixfmt-rfc-style" ];
          nix = ["alejandra"];
        };
        notify_on_error = true;
        notify_on_formatters = true;
        log_level = "trace";
        formaters = {
          alejandra = {command = "${lib.getExe pkgs.alejandra}";};
          # nixfmt-rfc-style = { command = "${lib.getExe pkgs.nixfmt-rfc-style}"; };
          # prettier . command = getExe .nodePackages.prettier;
          # prettierd . command = getExe pkgs.prettierd;
          # rustfmt . command = getExe pkgs.rustfmt;
        };
      };
    };
    fidget = {
      enable = true;
      autoLoad = true;
    };
  };
}
