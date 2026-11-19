{
  description = "Quine's additions to nixpkgs, as an overlay: only what nixpkgs lacks";

  # No inputs: an overlay goes on top of whichever nixpkgs its user has.
  outputs = {self}: {
    overlays.default = import ./overlay.nix;
  };
}
