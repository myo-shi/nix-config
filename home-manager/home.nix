# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  outputs,
  config,
  nixgl,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./programs/nvim.nix
    ./programs/alacritty.nix
    ./programs/tmux.nix
    ./programs/shell.nix
    ./programs/gnome-extensions/run-or-raise.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      #
      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  nixGL.packages = nixgl.packages;

  home = {
    username = "myo";
    homeDirectory = "/home/myo";
  };

  home.packages = with pkgs; [
    gcc
    nixfmt-rfc-style

    cascadia-code
    fira-code
    fira-code-symbols

    hello_nix
    better-adb-sync

    albert
    wl-clipboard

    fd
    bat
    vivid

    nodejs_22
    rustc
    cargo

    unstable.dwt1-shell-color-scripts
    gh

    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    monaspace
  ];

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "myo";
      userEmail = "myoshi.dev@gmail.com";
      extraConfig = {
        pull.rebase = true;
      };
    };

    ghostty = {
      enable = true;
      enableFishIntegration = true;
      package = config.lib.nixGL.wrap pkgs.ghostty;
      settings = {
        theme = "catppuccin-mocha";
        window-theme = "ghostty";
        background-opacity = 0.95;
        background-blur-radius = 20;
        gtk-tabs-location = "bottom";
        gtk-titlebar = false;
        window-padding-x = 8;
        window-padding-y = 8;
        window-padding-balance = true;
        keybind = [
          "ctrl+a>c=new_tab"
          "ctrl+a>n=next_tab"
          "ctrl+a>p=previous_tab"
          "ctrl+a>shift+t=toggle_tab_overview"

          "ctrl+a>shift+\\=new_split:right"
          "ctrl+a>-=new_split:down"

          "ctrl+a>h=goto_split:left"
          "ctrl+a>j=goto_split:bottom"
          "ctrl+a>l=goto_split:right"
          "ctrl+a>k=goto_split:top"

          "ctrl+shift+h=resize_split:left,40"
          "ctrl+shift+l=resize_split:right,40"
        ];
      };
    };

    gnome-shell = {
      enable = false;
      extensions = [
        { package = pkgs.gnomeExtensions.run-or-raise; }
        { package = pkgs.gnomeExtensions.blur-my-shell; }
      ];
    };
  };

  catppuccin = {
    starship.enable = true;
    fish.enable = true;
    bat.enable = true;
    alacritty.enable = true;
  };

  fonts.fontconfig.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
