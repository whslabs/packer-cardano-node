#! /usr/bin/env nix-shell
#! nix-shell --pure -i sh

set -ex

t=$(mktemp --suffix=.pkr.hcl)

cp cardano-node.pkr.hcl $t

sed -i 's/\(use_proxy\)/#\1/' $t

packer init -upgrade $t

packer build $t

rm $t
