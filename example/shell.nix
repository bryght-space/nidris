{ pkgs ? import <nixpkgs> {} }:

let
  nidris = import (fetchTarball "https://github.com/bryght-space/nidris/archive/6d1a87b32ef5005c0e05bf028fd098bd20bca285.tar.gz");
  idris = nidris ./.;
in
  pkgs.mkShell {
    buildInputs = [
      idris
    ];
  }


