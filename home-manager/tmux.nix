{ pkgs, config, ... }: {
  home.file.".tmux/plugins/tpm" = {
    source = builtins.fetchGit {
      url = "https://github.com/tmux-plugins/tpm";
      rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
    };
    recursive = true;
  };

  xdg.configFile."tmux/tmux.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/workspace/nix-config/dotfiles/tmux.conf";
    recursive = true;
  };
}
