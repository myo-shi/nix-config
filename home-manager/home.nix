# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  outputs,
  config,
  inputs,
  ...
}:
let
  ghosttyPkg = inputs.ghostty.packages.${pkgs.system}.default;
  codexPkg = inputs.codex-cli-nix.packages.${pkgs.system}.default;
  workmuxPkg = inputs.workmux.packages.${pkgs.system}.default;
in
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

  nix = {
    gc = {
      automatic = true;
      dates = "*-*-* 11:00:00";
      options = "-d";
    };
  };

  services = {
    home-manager.autoUpgrade = {
      enable = true;
      useFlake = true;
      flakeDir = "/home/myo/workspace/nix-config";
      frequency = "daily";
    };

  };

  home = {
    username = "myo";
    homeDirectory = "/home/myo";
  };

  home.packages = with pkgs; [
    nixfmt
    statix

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

    # nodejs_24
    # pnpm
    rustc
    cargo

    mise

    unstable.dwt1-shell-color-scripts
    gh

    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    monaspace

    # wrangler

    claude-code
    github-copilot-cli
    opencode
    codexPkg

    workmuxPkg
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
      # package = config.lib.nixGL.wrap pkgs.ghostty;
      package = config.lib.nixGL.wrap ghosttyPkg;
      settings = {
        adjust-cell-height = "20%";
        adjust-cell-width = "3%";
        clipboard-read = "allow";
        clipboard-write = "allow";
        copy-on-select = "clipboard";
        theme = "TokyoNight";
        window-theme = "ghostty";
        window-show-tab-bar = "always";
        background-opacity = 1;
        gtk-tabs-location = "bottom";
        gtk-titlebar = false;
        # gtk-titlebar-style = "tabs";
        gtk-toolbar-style = "flat";
        mouse-hide-while-typing = true;
        mouse-scroll-multiplier = 1;
        window-padding-x = 8;
        window-padding-y = 8;
        window-height = 60;
        window-width = 180;
        window-padding-balance = true;
        shell-integration-features = "ssh-terminfo,ssh-env";
        # command = "${pkgs.writeShellScript "tmux-launcher" ''
        #   if tmux has-session 2>/dev/null; then
        #     exec tmux attach
        #   else
        #     exec tmux new -s main
        #   fi
        # ''}";
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

    wezterm = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.wezterm;
      extraConfig = ''
        return {
         window_decorations = "TITLE | RESIZE"
        }
      '';
    };

    lazygit = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        os = {
          editCommand = "nvim";
          editCommandTemplate = "{{editor}} --server $NVIM --remote-tab {{filename}}";
        };
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

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    # zellij = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };

  };

  xdg.configFile."workmux/config.yaml".text = ''
    nerdfont: true
    merge_strategy: rebase
    agent: codex
    panes:
      - command: <agent>
        focus: true
      - split: horizontal
  '';

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
