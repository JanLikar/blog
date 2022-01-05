{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.python39
        pkgs.python39Packages.poetry
    ];
}
