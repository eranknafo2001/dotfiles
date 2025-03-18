{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./plugins/default.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;
    colorschemes.tokyonight = {
      enable = true;
      settings.style = "storm";
    };
    plugins = {
      undotree.enable = true;
      lz-n.enable = true;
    };
  };
}
