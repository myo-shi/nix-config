{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  xdg.configFile.nvim = {
    source = builtins.fetchGit {
      url = "https://github.com/LazyVim/starter.git";
      rev = "79b3f27f5cea8fe6bbb95ba04f93dffa545c5197";
    };
    recursive = true;
  };

  programs.lazygit.enable = true;
}
