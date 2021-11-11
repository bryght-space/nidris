{ pkgs ? import <nixpkgs> {} }:

let
  nidris = import (fetchTarball "https://github.com/bryght-space/nidris/archive/95d65f73c2e6e796191885c9b649edefd6391a42.tar.gz");
  idris = nidris "0.5.1";
in
  pkgs.mkShell {
    buildInputs = [
      idris
    ];
  }


