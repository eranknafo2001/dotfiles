{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  inherit (config.lib.nixvim) mkRaw listToUnkeyedAttrs;
in {
  programs.nixvim = {
    plugins = {
      blink-copilot = {
        enable = true;
        lazyLoad.settings.lazy = true;
      };
      blink-cmp = {
        enable = true;
        lazyLoad.settings = {
          lazy = true;
          before = mkRaw ''
            function()
              require("lz.n").trigger_load("blink-copilot")
            end
          '';
        };

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
        lazyLoad.settings = {
          before = mkRaw ''
            function()
              require("lz.n").trigger_load("blink.cmp")
            end
          '';
          event = [
            "BufNewFile"
            "BufReadPost"
            "BufWritePost"
          ];
        };
        capabilities = ''
          capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
        '';
        inlayHints = true;
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
        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "Workspace Symbol";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Actions";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
            "[d" = {
              action = "goto_next";
              desc = "Next Diagnostic";
            };
            "]d" = {
              action = "goto_prev";
              desc = "Previous Diagnostic";
            };
          };
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
                { "prettier", lsp_format = "fallback", stop_after_first = true }'';
            javascript =
              mkRaw ''
                { "prettier", lsp_format = "fallback", stop_after_first = true }'';
            typescript =
              mkRaw ''
                { "prettier", lsp_format = "fallback", stop_after_first = true }'';
            nix = ["alejandra"];
          };
          notify_on_error = true;
          notify_on_formatters = true;
          log_level = "trace";
        };
      };
      fidget = {
        enable = true;
        autoLoad = true;
      };
    };

    autoGroups.nvim-lint.clear = true;
    plugins.lint = {
      enable = true;

      lazyLoad.settings.event = [
        "BufNewFile"
        "BufReadPost"
        "BufWritePost"
      ];

      autoCmd = {
        desc = "Lint on read, write, and insert leave";
        event = [
          "BufReadPost"
          "BufWritePost"
          "InsertLeave"
        ];
        group = "nvim-lint";
      };

      linters = {
        deadnix.cmd = getExe pkgs.deadnix;
        statix.cmd = getExe pkgs.statix;
      };

      lintersByFt = {
        nix = [
          "deadnix"
          "statix"
        ];
      };
    };
    extraPackages = [pkgs.alejandra pkgs.nodePackages.prettier pkgs.prettierd pkgs.rustfmt];
  };
}
