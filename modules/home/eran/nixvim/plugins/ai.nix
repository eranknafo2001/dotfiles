{...}: {
  programs.nixvim.plugins = {
    copilot-chat = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
  };
}
