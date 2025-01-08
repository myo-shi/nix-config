{ config, ... }:
{
  xdg.configFile."run-or-raise/shortcuts.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/nix-config/dotfiles/run-or-raise/shortcuts.conf";
    recursive = true;
  };
}
