{ pkgs, ... }:
{
  home.packages = with pkgs; [ unstable.fnm ];

  xdg.configFile."fish/conf.d/fnm.fish" = {
    text =
      "fnm env --corepack-enabled"
      + " --version-file-strategy=recursive"
      + " --use-on-cd"
      + " --resolve-engines"
      + " | source";
  };
}
