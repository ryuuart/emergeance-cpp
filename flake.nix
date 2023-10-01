{
  description = "Emerging C++ Idea";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    # specify system
    let
      systems = [ "aarch64-darwin" "x86_64-linux" "aarch64-linux" ];
    in
    flake-utils.lib.eachSystem systems (system:
      let
        # package setup
        pkgs = import nixpkgs { 
          inherit system;
        };
        llvm = pkgs.llvmPackages_16;
        stdenv = llvm.stdenv;

        # shared packages
        sharedPackages = [
            # tooling
            pkgs.cmake
            pkgs.clang-tools_16

            # package management
            pkgs.conan
        ];
      in
      rec {
        devShells.default = pkgs.mkShell.override { inherit stdenv; } {
          packages = [
          ] ++ sharedPackages;

          shellHook = ''
            echo
            echo "     [[[[[  Welcome to the Nebula  ]]]]]"
            echo "     ᚤᛟᚢ ᚨᚱᛖ ᛒᛖᚲᛟᛗᛁᚾᚷ ᛟᚾᛖ ᚹᛁᛏᚺ ᛏᚺᛖ ᛋᛏᚨᚱᛋ"
            echo "     [[[[[  •+-#—*#•-##++-*+-+••## ]]]]]"
            echo
          '';
        };

        packages = rec {
          default = pkgs.stdenv.mkDerivation {
            name = "nebula";
            version = "0.1.0";
            src = self;

            nativeBuildInputs = [
            ] ++ sharedPackages;

            buildPhase = ''
              cmake --build . 
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp Nebula $out/bin
            '';
          };
        };
      }
    );
}
