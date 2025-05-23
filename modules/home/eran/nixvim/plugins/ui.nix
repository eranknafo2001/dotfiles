{config, ...}: let
  inherit (config.lib.nixvim) mkRaw listToUnkeyedAttrs;
in {
  programs.nixvim.plugins = {
    bufferline = {
      enable = true;
      lazyLoad.settings = {
        event = "DeferredUIEnter";
        keys = [
          ((listToUnkeyedAttrs ["<leader>bp" "<Cmd>BufferLineTogglePin<CR>"]) // {desc = "Toggle Pin";})
          ((listToUnkeyedAttrs ["<leader>bP" "<Cmd>BufferLineGroupClose ungrouped<CR>"]) // {desc = "Delete Non-Pinned Buffers";})
          ((listToUnkeyedAttrs ["<leader>br" "<Cmd>BufferLineCloseRight<CR>"]) // {desc = "Delete Buffers to the Right";})
          ((listToUnkeyedAttrs ["<leader>bl" "<Cmd>BufferLineCloseLeft<CR>"]) // {desc = "Delete Buffers to the Left";})
          ((listToUnkeyedAttrs ["<S-h>" "<cmd>BufferLineCyclePrev<cr>"]) // {desc = "Prev Buffer";})
          ((listToUnkeyedAttrs ["<S-l>" "<cmd>BufferLineCycleNext<cr>"]) // {desc = "Next Buffer";})
          ((listToUnkeyedAttrs ["[b" "<cmd>BufferLineCyclePrev<cr>"]) // {desc = "Prev Buffer";})
          ((listToUnkeyedAttrs ["]b" "<cmd>BufferLineCycleNext<cr>"]) // {desc = "Next Buffer";})
          ((listToUnkeyedAttrs ["[B" "<cmd>BufferLineMovePrev<cr>"]) // {desc = "Move buffer prev";})
          ((listToUnkeyedAttrs ["]B" "<cmd>BufferLineMoveNext<cr>"]) // {desc = "Move buffer next";})
        ];
      };
      settings.options = {
        mode = "buffers";
        close_command = mkRaw "function(n) Snacks.bufdelete(n) end";
        right_mouse_command = mkRaw "function(n) Snacks.bufdelete(n) end";
        # diagnostics = "nvim_lsp";
        always_show_bufferline = false;
        # tab_size = 50;
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
          {
            filetype = "snacks_layout_box";
          }
        ];
      };
    };
    nvim-tree = {
      enable = true;
      disableNetrw = true;
      updateFocusedFile.enable = true;
    };
    gitsigns = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    web-devicons = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    which-key = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
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
      layout = let
        padding = val: {
          type = "padding";
          inherit val;
        };
      in [
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
          on_press = mkRaw "function() require('lz.n').trigger_load('fzf-lua'); smart_files() end";
          opts = {
            keymap = [
              "n"
              "f"
              (mkRaw "function() require('lz.n').trigger_load('fzf-lua'); smart_files() end")
              {
                noremap = true;
                silent = true;
                nowait = true;
              }
            ];
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
            keymap = [
              "n"
              "n"
              ":ene <BAR> startinsert <CR>"
              {
                noremap = true;
                silent = true;
                nowait = true;
              }
            ];
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
          on_press = mkRaw "function() require('lz.n').trigger_load('fzf-lua'); require('fzf-lua').oldfiles() end";
          opts = {
            keymap = [
              "n"
              "r"
              ":FzfLua oldfiles <CR>"
              {
                noremap = true;
                silent = true;
                nowait = true;
              }
            ];
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
          on_press = mkRaw "function() require('lz.n').trigger_load('fzf-lua'); require('fzf-lua').live_grep() end";
          opts = {
            keymap = [
              "n"
              "g"
              ":FzfLua live_grep <CR>"
              {
                noremap = true;
                silent = true;
                nowait = true;
              }
            ];
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
          on_press = mkRaw "function() require('lz.n').trigger_load('persistence'); require('persistence').load() end";
          opts = {
            keymap = [
              "n"
              "s"
              (mkRaw "function() require('lz.n').trigger_load('persistence'); require('persistence').load() end")
              {
                noremap = true;
                silent = true;
                nowait = true;
              }
            ];
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
            keymap = [
              "n"
              "q"
              ":qa<CR>"
              {
                noremap = true;
                silent = true;
                nowait = true;
              }
            ];
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
    lualine = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    fzf-lua = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings = {
          cmd = "FzfLua";
          keys = [
            ((listToUnkeyedAttrs ["<leader><space>" (mkRaw "function() _G.smart_files() end")]) // {desc = "Files";})
            ((listToUnkeyedAttrs ["<leader>ff" (mkRaw "function() _G.smart_files() end")]) // {desc = "Files";})
            ((listToUnkeyedAttrs ["<leader>sg" (mkRaw "function() require('fzf-lua').live_grep() end")]) // {desc = "Live Grep";})
            ((listToUnkeyedAttrs ["<leader>sb" (mkRaw "function() require('fzf-lua').buffers() end")]) // {desc = "Buffers";})
          ];
        };
      };
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
    };
  };
}
