#!/bin/bash -v

host=$1
folder=$2

echo "Installing on host ${host}"

echo "Updating packages"
yum update -y

echo "Installing yum packages"
yum install -y rubygems git puppet3

echo "Installing rubygems"
gem install r10k hiera-eyaml hiera-eyaml-kms

echo "Running r10k"
pushd /root/init
/usr/local/bin/r10k puppetfile install -v debug &> r10k.log

echo "Running Puppet"
puppet apply site.pp --hiera_config hiera.yaml --modulepath=modules:site &> puppet.log
popd

echo "Done with INIT."
