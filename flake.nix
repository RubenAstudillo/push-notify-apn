{
  # inspired by: https://serokell.io/blog/practical-nix-flakes#packaging-existing-applications
  description = "A Hello World in Haskell with a dependency and a devShell";
  inputs.nixpkgs.url = "nixpkgs";
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      });
      f = import ./default.nix ;
    in
    {
      overlay = (final: prev: {
        push-notify-apn = final.haskellPackages.callPackage f {};
      });
      packages = forAllSystems (system: {
         push-notify-apn = nixpkgsFor.${system}.push-notify-apn;
      });
      defaultPackage = forAllSystems (system: self.packages.${system}.push-notify-apn);
      checks = self.packages;
      devShell = forAllSystems (system: let haskellPackages = nixpkgsFor.${system}.haskellPackages;
        in haskellPackages.shellFor {
          packages = p: [self.packages.${system}.push-notify-apn];
          withHoogle = true;
          buildInputs = with haskellPackages; [
            haskell-language-server
            cabal-install
          ];
        }
      );
    };
}
