{
  pkgs,
  outputs,
  config,
  nixgl,
  inputs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    ./home.nix
    ./programs/gnome-extensions/run-or-raise.nix
  ];

  targets = {
    genericLinux = {
      enable = true;
      nixGL = {
        packages = nixgl.packages;
      };
    };
  };

  home = {
    username = "myo";
    homeDirectory = "/home/myo";
  };

  home.packages = with pkgs; [
    albert
    wl-clipboard
  ];

  programs = {
    home-manager = {
      enable = true;
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
    fish.enable = true;
    bat.enable = true;
    alacritty.enable = true;
  };

  fonts.fontconfig.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
