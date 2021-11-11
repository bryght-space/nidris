{ pkgs ? import <nixpkgs> {} }:

let
  nidris = import (fetchTarball "https://github.com/bryght-space/nidris/archive/6b1641035e284ae1d90babf31c7161dbe1cde42f.tar.gz");
  idris = nidris "0.5.1";
in
  pkgs.mkShell {
    buildInputs = [
      idris
    ];
  }


