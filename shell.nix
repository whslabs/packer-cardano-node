{
  pkgs ? import sources.nixpkgs { },
  sources ? import nix/sources.nix,
}:
pkgs.mkShell { nativeBuildInputs = [
  pkgs.ansible
  pkgs.packer
]; }
