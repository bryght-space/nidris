{ pkgs ? import <nixpkgs> {} }:

let
  nidris = import (fetchTarball "https://github.com/bryght-space/nidris/archive/b81518400dc44c599e129b390c22dc7576571f41.tar.gz");
  idris = nidris ./.;
in
  pkgs.mkShell {
    buildInputs = [
      idris
    ];
  }


