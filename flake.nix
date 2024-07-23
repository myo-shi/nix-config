{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
      nixgl,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
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
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.myo = import ./home-manager/home.nix;
            }
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "myo@um790pro-arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          # > Our main home-manager configuration file <
          modules = [
            { targets.genericLinux.enable = true; }
            ./home-manager/home.nix
          ];
        };
      };
    };
}
