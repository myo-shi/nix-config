{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixgl, ... }@inputs:
    let 
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgsUnstable = import nixpkgs-unstable {inherit system;};
    in {
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

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # FIXME replace with your username@hostname
        "myo@um790pro-arch" = home-manager.lib.homeManagerConfiguration {
          #pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixgl.overlay ];
          };
          extraSpecialArgs = { inherit inputs outputs pkgsUnstable; };
          # > Our main home-manager configuration file <
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}
