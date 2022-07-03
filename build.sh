#! /usr/bin/env nix-shell
#! nix-shell --pure -i sh

set -ex

f=cardano-node.pkr.hcl

packer init -upgrade $f

packer build $f
