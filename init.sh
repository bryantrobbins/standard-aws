#!/bin/bash -v

echo "Updating packages"
yum update -y

echo "Installing packages"
yum install -y rubygems git puppet3

echo "Installing r10k"
gem install r10k

echo "Running r10k"
pushd /root/bootstrap/instances/build
r10k puppetfile install -v DEBUG | tee /var/log/puppet/r10k.log
popd

echo "Running Puppet"
pushd /root/bootstrap/instances/build
puppet apply -l /var/log/puppet/site.log site.pp
popd

echo "Done with INIT."
