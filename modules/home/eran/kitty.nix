{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
      term = "xterm-256color";
    };
  };
}
