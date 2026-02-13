{
  inputs,
  system,
  ...
}: {
  programs.claude-code = {
    enable = true;
    package = inputs.claude-code.packages.${system}.default;
  };
}
