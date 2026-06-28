{
  description = "Guy Marino's systems — nix-darwin + home-manager on Determinate Nix";

  inputs = {
    # Everything tracks unstable.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils/main";

    # Makes nix-darwin coexist with the Determinate-managed Nix.
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    # Whole VSCode marketplace as nix packages.
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      mac-app-util,
      home-manager,
      flake-utils,
      determinate,
      nix-vscode-extensions,
      treefmt-nix,
    }:
    let
      # Per-system devShell creator
      mkEnv =
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          treefmt-config = treefmt-nix.lib.evalModule pkgs {
            projectRootFile = "flake.nix";

            programs.nixfmt.enable = true;
            programs.nixfmt.package = pkgs.nixfmt-rfc-style; # Use standard
          };
        in
        {
          formatter = treefmt-config.config.build.wrapper;

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              treefmt
              nixfmt
              statix
              deadnix
            ];
          };
        };

      # Per-machine builder; `theme` is the single per-machine theme switch.
      mkDarwin =
        {
          system,
          host,
          theme,
        }:
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
    }
    // flake-utils.lib.eachDefaultSystem mkEnv;
}
