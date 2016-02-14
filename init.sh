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

echo "Fetching latest Puppet configurations"

echo "Running r10k"
/usr/local/bin/r10k puppetfile install -v debug2 &> /var/log/puppet/r10k.log

echo "Running Puppet"
/usr/bin/puppet apply -l /var/log/puppet/site.log --hiera_config hiera.yaml site.pp

echo "Done with INIT."
