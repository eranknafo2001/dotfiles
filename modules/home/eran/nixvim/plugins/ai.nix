{config, ...}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  sops.secrets = {
    anthropic_key = {};
    openai_key = {};
    tavily_key = {};
  };
  programs.nixvim.plugins = {
    supermaven = {
      enable = true;

      settings = {
        keymaps = {
          accept_suggestion = "<Tab>";
          clear_suggestions = "<C-]>";
          accept_word = "<C-j>";
        };
        ignore_filetypes = ["cpp"];
        color = {
          suggestion_color = "#ffffff";
          cterm = 244;
        };
        log_level = "info";
        disable_inline_completion = false;
        disable_keymaps = false;
        condition = mkRaw ''
          function()
            return false
          end
        '';
      };
    };
    avante = {
      enable = true;
      luaConfig.pre = ''
        vim.env.OPENAI_API_KEY = table.concat(vim.fn.readfile("${config.sops.secrets.openai_key.path}"), "\n")
        vim.env.ANTHROPIC_API_KEY = table.concat(vim.fn.readfile("${config.sops.secrets.anthropic_key.path}"), "\n")
        vim.env.TAVILY_API_KEY = table.concat(vim.fn.readfile("${config.sops.secrets.tavily_key.path}"), "\n")
      '';
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        input = {
          provider = "snacks";
          provider_opts = {
            title = "Avante Input";
            icon = " ";
            placeholder = "Enter your API key...";
          };
        };
      };
    };
  };
}
