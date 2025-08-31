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

  nixGL.packages = nixgl.packages;

  home = {
    username = "myo";
    homeDirectory = "/home/myo";
  };

  home.packages = with pkgs; [
    albert
    wl-clipboard

    # (config.lib.nixGL.wrap inputs.claude-desktop.packages.${system}.claude-desktop)
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

  xdg.desktopEntries.claude-desktop = {
    name = "claude-desktop";
    exec = "claude-desktop %u --no-sandbox --ozone-platform-hint=auto --enable-wayland-ime --wayland-text-input-version=3  --enable-unsafe-swiftshader";
    icon = "claude";
    type = "Application";
    terminal = false;
    categories = [
      "Office"
      "Utility"
    ];
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
