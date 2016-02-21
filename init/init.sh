#!/bin/bash -v

echo "Updating packages"
yum update -y

echo "Installing yum packages"
yum install -y rubygems git puppet3

echo "Installing rubygems"
gem install r10k hiera-eyaml hiera-eyaml-kms

./update.sh

echo "Done with INIT."
