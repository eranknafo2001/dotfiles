{ config, ... }: {
  programs.nixvim.plugins = let mkRaw = config.lib.nixvim.mkRaw; in {
    bufferline.enable = true;
    nvim-tree = {
      enable = true;
      disableNetrw = true;
      updateFocusedFile.enable = true;
    };
    gitsigns.enable = true;
    web-devicons.enable = true;
    which-key = {
      enable = true;
      settings = {
        preset = "helix";
        spec = mkRaw ''
          {
            {
              mode = { "n", "v" },
              { "<leader><tab>", group = "tabs" },
              { "<leader>c", group = "code" },
              { "<leader>d", group = "debug" },
              { "<leader>dp", group = "profiler" },
              { "<leader>f", group = "file/find" },
              { "<leader>g", group = "git" },
              { "<leader>gh", group = "hunks" },
              { "<leader>q", group = "quit/session" },
              { "<leader>s", group = "search" },
              { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
              { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
              { "[", group = "prev" },
              { "]", group = "next" },
              { "g", group = "goto" },
              { "gs", group = "surround" },
              { "z", group = "fold" },
              {
                "<leader>b",
                group = "buffer",
                expand = function()
                  return require("which-key.extras").expand.buf()
                end,
              },
              {
                "<leader>w",
                group = "windows",
                proxy = "<c-w>",
                expand = function()
                  return require("which-key.extras").expand.win()
                end,
              },
              -- better descriptions
              { "gx", desc = "Open with system app" },
            },
          }
        '';
      };
    };
    snacks.enable = true;
    alpha = {
      enable = true;
      layout =
        let
          padding = val: {
            type = "padding";
            inherit val;
          };
        in
        [
          (padding 4)
          {
            opts = {
              hl = "AlphaHeader";
              position = "center";
            };
            type = "text";
            val = [
              "⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝"
              "⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇"
              "⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀"
              "⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀"
              "⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀"
              "⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀"
            ];
          }
          (padding 6)
          {
            type = "button";
            val = "  Find File";
            on_press = mkRaw "smart_files";
            opts = {
              keymap = [ "n" "f" (mkRaw "smart_files") { noremap = true; silent = true; nowait = true; } ];
              shortcut = "f";

              position = "center";
              cursor = 3;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          (padding 1)
          {
            type = "button";
            val = "  New File";
            on_press = mkRaw "function() vim.cmd[[ene]] end";
            opts = {
              keymap = [ "n" "n" ":ene <BAR> startinsert <CR>" { noremap = true; silent = true; nowait = true; } ];
              shortcut = "n";

              position = "center";
              cursor = 3;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          (padding 1)
          {
            type = "button";
            val = "󰈚  Recent Files";
            on_press = mkRaw "require('fzf-lua').oldfiles";
            opts = {
              keymap = [ "n" "r" ":FzfLua oldfiles <CR>" { noremap = true; silent = true; nowait = true; } ];
              shortcut = "r";

              position = "center";
              cursor = 3;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          (padding 1)
          {
            type = "button";
            val = "󰈭  Find Word";
            on_press = mkRaw "require('fzf-lua').live_grep";
            opts = {
              keymap = [ "n" "g" ":Telescope live_grep <CR>" { noremap = true; silent = true; nowait = true; } ];
              shortcut = "g";

              position = "center";
              cursor = 3;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          (padding 1)
          {
            type = "button";
            val = "  Restore Session";
            on_press = mkRaw "require('persistence').load";
            opts = {
              keymap = [ "n" "s" ":lua require('persistence').load()<cr>" { noremap = true; silent = true; nowait = true; } ];
              shortcut = "s";

              position = "center";
              cursor = 3;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
          (padding 1)
          {
            type = "button";
            val = "  Quit Neovim";
            on_press = mkRaw "function() vim.cmd[[qa]] end";
            opts = {
              keymap = [ "n" "q" ":qa<CR>" { noremap = true; silent = true; nowait = true; } ];
              shortcut = "q";

              position = "center";
              cursor = 3;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          }
        ];
    };
    lightline.enable = true;
    fzf-lua = {
      enable = true;
      luaConfig.post = ''
        function _G.smart_files()
          local function is_git_repo()
            local git_dir = vim.fn.finddir(".git", ".;")
            return git_dir ~= ""
          end
          
          if is_git_repo() then
            require("fzf-lua").git_files()
          else
            require("fzf-lua").files()
          end
        end
      '';
      settings = {
        git.files.cmd = "git ls-files --exclude-standard --others --cached";
      };
      keymaps = {
        "<leader><space>" = {
          action = "function() _G.smart_files() end";
          options = {
            silent = true;
            desc = "Files";
          };
        };
        "<leader>ff" = {
          action = "function() _G.smart_files() end";
          options = {
            silent = true;
            desc = "Files";
          };
        };
        "<leader>sg" = {
          action = "live_grep";
          options = {
            silent = true;
            desc = "Live Grep";
          };
        };
      };
    };
  };
}
