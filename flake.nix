{
  description = "Arkive Web Interface";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    # mk-node is a thin wrapper around node2nix
    # for some reason i couldn't get this to build using node2nix directly,
    # but it builds using mk-node.
    mk-node.url = "github:sephii/mk-node";

    # TODO: add flake utils system attrset for multiple arch support
  };

  outputs = { self, nixpkgs, mk-node }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; overlays = [ mk-node.overlay ]; };
      nodejs = pkgs.nodejs-16_x;
      nodeModules = pkgs.mkNodeModules { src = ./.; inherit nodejs; };
    in
    {
      defaultPackage.${system} = pkgs.stdenv.mkDerivation {
        name = "arkive-web";
        src = self;

        buildPhase = ''
          ln -s ${nodeModules}/lib/node_modules ./node_modules
          export PATH="${nodeModules}/bin:$PATH"
          ${nodejs}/bin/npm run build
        '';

        installPhase = ''
          mkdir -p $out;
          cp -r build/* $out/
        '';
      };
    };
}
