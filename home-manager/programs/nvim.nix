{
  pkgs,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = true;
    # package = pkgs.neovim-unwrapped;
    package = (
      pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
        version = "0.9.5";
        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "v0.9.5";
          hash = "sha256-CcaBqA0yFCffNPmXOJTo8c9v1jrEBiqAl8CG5Dj5YxE=";
        };
        buildInputs =
          oldAttrs.buildInputs
          ++ (with pkgs; [
            libtermkey
            libvterm-neovim
            unibilium
            msgpack
            libuv
            luajit
            tree-sitter
            libmpack
          ]);
      })
    );
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
