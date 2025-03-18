{ config, ... }: {
  programs.nixvim.keymaps = let mkRaw = config.lib.nixvim.mkRaw;
  in [
    {
      action = mkRaw "function() Snacks.bufdelete() end";
      key = "<leader>bd";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Delete Buffer";
      };
    }
    {
      action = mkRaw "function() Snacks.bufdelete.other() end";
      key = "<leader>bo";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Delete Other Buffers";
      };
    }
    {
      action = "<cmd>:bd<cr>";
      key = "<leader>bD";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Delete Buffer and Window";
      };
    }
    {
      action = "<cmd>w<cr><esc>";
      key = "<C-s>";
      mode = [ "i" "x" "n" "s" ];
      options = {
        silent = true;
        desc = "Save File";
      };
    }
    {
      action = mkRaw ''function() require("conform").format() end'';
      key = "<leader>cf";
      mode = [ "n" "v" ];
      options = {
        silent = true;
        desc = "Format";
      };
    }
    {
      action = mkRaw "function() Snacks.picker.git_log_line() end";
      key = "<leader>gb";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Git Blame Line";
      };
    }
    {
      action = mkRaw "function() Snacks.gitbrowse() end";
      key = "<leader>gB";
      mode = [ "n" "x" ];
      options = {
        silent = true;
        desc = "Git Browse (open)";
      };
    }
    {
      action = "<cmd>qa<cr>";
      key = "<leader>qq";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Quit All";
      };
    }
    {
      action = mkRaw "function() vim.show_pos() end";
      key = "<leader>ui";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Inspect Pos";
      };
    }
    {
      action = mkRaw ''
        function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end'';
      key = "<leader>uI";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Inspect Tree";
      };
    }
    {
      action = mkRaw "function() Snacks.terminal() end";
      key = "<leader>ft";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Terminal (cwd)";
      };
    }
    {
      action = "<cmd>close<cr>";
      key = "<C-/>";
      mode = [ "t" ];
      options = {
        silent = true;
        desc = "Hide Terminal";
      };
    }
    {
      action = "<cmd>close<cr>";
      key = "<c-_>";
      mode = [ "t" ];
      options = {
        silent = true;
        desc = "which_key_ignore";
      };
    }
    {
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<cr>";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Toggle File Explorer";
      };
    }
    {
      action = "<C-w>l";
      key = "<C-l>";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Window Right";
      };
    }
    {
      action = "<C-w>k";
      key = "<C-k>";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Window Up";
      };
    }
    {
      action = "<C-w>j";
      key = "<C-j>";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Window Down";
      };
    }
    {
      action = "<C-w>h";
      key = "<C-h>";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Window Left";
      };
    }
    {
      action = ''"+p'';
      key = "<leader>p";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Clipbord Paste";
      };
    }
    {
      action = ''"+p'';
      key = "<leader>p";
      mode = [ "v" ];
      options = {
        silent = true;
        desc = "Clipbord Paste";
      };
    }
    {
      action = ''"+P'';
      key = "<leader>P";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Clipbord Paste";
      };
    }
    {
      action = ''"+y'';
      key = "<leader>y";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Clipbord Yank";
      };
    }
    {
      action = ''"+y'';
      key = "<leader>y";
      mode = [ "v" ];
      options = {
        silent = true;
        desc = "Clipbord Yank";
      };
    }
    {
      action = ''"+d'';
      key = "<leader>d";
      mode = [ "v" ];
      options = {
        silent = true;
        desc = "Clipbord Yank";
      };
    }
    {
      action = ''"+d'';
      key = "<leader>d";
      mode = [ "n" ];
      options = {
        silent = true;
        desc = "Clipbord Yank";
      };
    }
  ];

}
