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
    # ./nvim.nix
    ./alacritty.nix
    ./tmux.nix
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

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    tmux
    nixfmt-rfc-style
    starship
    # unstable.fnm
    cascadia-code
    fira-code
    fira-code-symbols

    hello_nix
    better-adb-sync

    # Patching nerdfonts
    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "FiraCode"
        "JetBrainsMono"
      ];
    })
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "myo";
    userEmail = "myoshi.dev@gmail.com";
    extraConfig = {
      pull.rebase = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  # fnm settings
  # xdg.configFile."fish/conf.d/fnm.fish" = {
  #   text =
  #     "fnm env --corepack-enabled"
  #     + " --version-file-strategy=recursive"
  #     + " --use-on-cd"
  #     + " --resolve-engines"
  #     + " | source";
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  fonts.fontconfig.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
