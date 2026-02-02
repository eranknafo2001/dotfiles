# Git configuration
{...}: {
  homeModules = [
    ({...}: {
      programs.diff-so-fancy.enable = true;
      programs.git = {
        enable = true;
        settings = {
          user.name = "Eran Knafo";
          user.email = "eranknafo2001@gmail.com";
          alias = {
            co = "checkout";
            br = "branch";
            st = "status";
          };
        };
      };
    })
  ];
}
