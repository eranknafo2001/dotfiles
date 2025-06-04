{config, ...}: {
  sops.secrets.anthropic_key = {};
  programs.nixvim.plugins = {
    copilot-chat = {
      enable = false;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    avante = {
      enable = true;
      luaConfig.pre = ''
        vim.env.OPENAI_API_KEY = table.concat(vim.fn.readfile("${config.sops.secrets.openai_key.path}"), "\n")
        vim.env.ANTHROPIC_API_KEY = table.concat(vim.fn.readfile("${config.sops.secrets.anthropic_key.path}"), "\n")
      '';
      lazyLoad.settings.event = "DeferredUIEnter";
    };
  };
}
