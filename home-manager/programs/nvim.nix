{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/workspace/nix-config/dotfiles/nvim";
    recursive = true;
  };

  # xdg.configFile.nvim = {
  #   source = builtins.fetchGit {
  #     url = "https://github.com/LazyVim/starter.git";
  #     rev = "79b3f27f5cea8fe6bbb95ba04f93dffa545c5197";
  #   };
  #   recursive = true;
  # };

  programs.lazygit.enable = true;
}
