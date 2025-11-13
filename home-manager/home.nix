# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  outputs,
  config,
  nixgl,
  nixpkgs-for-neovim,
  inputs,
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
    # ./programs/gnome-extensions/run-or-raise.nix
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

  nix.gc.automatic = true;
  nix.gc.dates = "Mon *-*-* 11:00:00";
  nix.gc.options = "-d";

  # nixGL.packages = nixgl.packages;

  home = {
    username = "myo";
    homeDirectory = "/home/myo";
  };

  home.packages = with pkgs; [
    nixfmt-rfc-style

    cascadia-code
    fira-code
    fira-code-symbols

    hello_nix
    android-tools
    better-adb-sync

    # albert
    # wl-clipboard

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

    # (config.lib.nixGL.wrap inputs.claude-desktop.packages.${system}.claude-desktop)
    wrangler

    claude-code
  ];

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "myo";
          email = "myoshi.dev@gmail.com";
        };
        extraConfig = {
          pull.rebase = true;
        };
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    ghostty = {
      enable = true;
      enableFishIntegration = true;
      package = config.lib.nixGL.wrap pkgs.ghostty;
      settings = {
        theme = "TokyoNight";
        window-theme = "ghostty";
        background-opacity = 0.95;
        background-blur-radius = 20;
        gtk-tabs-location = "hidden";
        gtk-titlebar = false;
        window-padding-x = 8;
        window-padding-y = 8;
        window-padding-balance = true;
        # command = "tmux";
        command = "${pkgs.writeShellScript "tmux-launcher" ''
          if tmux has-session 2>/dev/null; then
            exec tmux attach
          else
            exec tmux new -s main
          fi
        ''}";
        keybind = [
          # "ctrl+a>c=new_tab"
          # "ctrl+a>n=next_tab"
          # "ctrl+a>p=previous_tab"
          # "ctrl+a>shift+t=toggle_tab_overview"
          #
          # "ctrl+a>shift+\\=new_split:right"
          # "ctrl+a>-=new_split:down"
          #
          # "ctrl+a>h=goto_split:left"
          # "ctrl+a>j=goto_split:bottom"
          # "ctrl+a>l=goto_split:right"
          # "ctrl+a>k=goto_split:top"
          #
          # "ctrl+shift+h=resize_split:left,40"
          # "ctrl+shift+l=resize_split:right,40"
        ];
      };
    };

    wezterm = {
      enable = true;
      package = (config.lib.nixGL.wrap pkgs.wezterm);
      extraConfig = ''
        return {
         window_decorations = "TITLE | RESIZE"
        }
      '';
    };

    lazygit = {
      enable = true;
      settings = {
        git.pagers = [
          {
            colorArg = "always";
            pager = "delta --dark --paging=never -s";
          }
        ];
      };
    };

    sherlock = {
      enable = true;
    };

    # gnome-shell = {
    #   enable = false;
    #   extensions = [
    #     { package = pkgs.gnomeExtensions.run-or-raise; }
    #     { package = pkgs.gnomeExtensions.blur-my-shell; }
    #   ];
    # };

  };

  # xdg.desktopEntries.claude-desktop = {
  #   name = "claude-desktop";
  #   exec = "claude-desktop %u --no-sandbox --ozone-platform-hint=auto --enable-wayland-ime --wayland-text-input-version=3  --enable-unsafe-swiftshader";
  #   icon = "claude";
  #   type = "Application";
  #   terminal = false;
  #   categories = [
  #     "Office"
  #     "Utility"
  #   ];
  # };

  catppuccin = {
    fish.enable = true;
    bat.enable = true;
    alacritty.enable = true;
    lazygit.enable = true;
    delta.enable = true;
  };

  fonts.fontconfig.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
