{
  description = "Your new nix config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    ghostty.url = "github:ghostty-org/ghostty";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix/pull/64/head";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    workmux.url = "github:raine/workmux";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
      nixgl,
      catppuccin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        # "aarch64-linux"
        # "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        # "x86_64-darwin"
      ];

      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;

      makeHomeConfig =
        pkgs: modules:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs outputs nixgl; };
          inherit modules;
        };
    in
    {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      overlays = import ./overlays { inherit inputs; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      #nixosConfigurations = {
      #  # FIXME replace with your hostname
      #  your-hostname = nixpkgs.lib.nixosSystem {
      #    specialArgs = {inherit inputs outputs;};
      #    # > Our main nixos configuration file <
      #    modules = [./nixos/configuration.nix];
      #  };
      #};

      # Darwin Configuration
      # https://daiderd.com/nix-darwin/manual/index.html
      darwinConfigurations = {
        "myo@mba" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                manager.useUserPackages = true;
                manager.users.myo = import ./home-manager/home.nix;
              };
            }
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "arch" = makeHomeConfig nixpkgs.legacyPackages.x86_64-linux [
          { targets.genericLinux.enable = true; }
          ./home-manager/home-linux.nix
          catppuccin.homeModules.catppuccin
        ];

        "myo@florida-ubuntu" = makeHomeConfig nixpkgs.legacyPackages.x86_64-linux [
          { targets.genericLinux.enable = true; }
          ./home-manager/home-linux.nix
          catppuccin.homeModules.catppuccin
        ];
        "myo@ohio-eos" = makeHomeConfig nixpkgs.legacyPackages.x86_64-linux [
          { targets.genericLinux.enable = true; }
          ./home-manager/home-linux.nix
          catppuccin.homeModules.catppuccin
        ];
      };
    };
}
