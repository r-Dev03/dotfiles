 # When you add custom packages, list them here
# These are similar to nixpkgs packages
final: _prev: {
  ligalex-mono = final.callPackage ./fonts/ligalex-mono.nix {};
}
