#!/bin/bash

branch="release"
current_branch=`git rev-parse --abbrev-ref HEAD`

tmp_dir=$(mktemp -d -t nidris-XXXXXXXXXX)

cp -Rf src/* $tmp_dir

git pull

if (git rev-parse --verify $branch)
then
  echo "checkout existing version of the branch"
  extraPushParams=""
  git checkout $branch
else
  if (git rev-parse --verify origin/$branch)
  then
    echo "checkout existing version of remote the branch"
    extraPushParams=""
    git checkout -b $branch origin/release
  else
    echo "initial version of the branch"
    extraPushParams="--set-upstream origin $branch"
    git checkout --orphan $branch
  fi
fi

git rm --ignore-unmatch -rf .
git clean -f

cp -Rf $tmp_dir/* .

git add .
git commit --allow-empty -m "[skip actions] Add new release"

version=`git rev-parse --verify HEAD`

git push $extraPushParams
git checkout $current_branch

git reset --hard $current_branch
git clean -f



mkdir -p example

echo "{ pkgs ? import <nixpkgs> {} }:

let
  nidris = import (fetchTarball \"https://github.com/bryght-space/nidris/archive/${version}.tar.gz\");
  idris = nidris \"0.5.1\";
in
  pkgs.mkShell {
    buildInputs = [
      idris
    ];
  }

" > example/shell.nix

git add .
git commit --allow-empty -m "[skip actions] Update example"
git push
