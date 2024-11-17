# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  pkgs,
  outputs,
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
      inputs.nixgl.overlay

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

    fd
    bat
    vivid

    nodejs_22
    rustc
    cargo

    # Patching nerdfonts
    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "FiraCode"
        "JetBrainsMono"
      ];
    })
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
  };

  fonts.fontconfig.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
