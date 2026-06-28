{
  description = "Guy Marino's systems — nix-darwin + home-manager on Determinate Nix";

  inputs = {
    # Everything tracks unstable.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Makes nix-darwin coexist with the Determinate-managed Nix.
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    # Whole VSCode marketplace as nix packages.
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, determinate, nix-vscode-extensions }:
    let
      # Per-machine builder; `theme` is the single per-machine theme switch.
      mkDarwin = { system, host, theme }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs theme; };
          modules = [
            determinate.darwinModules.default
            home-manager.darwinModules.home-manager
            { nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ]; }
            ./darwin
            ./darwin/hosts/${host}.nix
          ];
        };
    in
    {
      darwinConfigurations.pegasus = mkDarwin {
        system = "aarch64-darwin";
        host = "pegasus";
        theme = "forest";
      };

      # `direnv` dev-shell for hacking on this repo.
      devShells.aarch64-darwin.default =
        let pkgs = import nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
        in pkgs.mkShell {
          packages = with pkgs; [ nixfmt-rfc-style nil statix deadnix ];
        };
    };
}
