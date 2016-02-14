#!/bin/bash -v

host=$1
hostdir="/root/bootstrap/hosts/${host}"

echo "Installing on host ${host}"

echo "Updating packages"
yum update -y

echo "Installing packages"
yum install -y rubygems git puppet3

echo "Installing r10k"
gem install r10k

echo "Running r10k"
pushd ${hostdir}
/usr/local/bin/r10k puppetfile install -v debug2 &> /var/log/puppet/r10k.log
popd

echo "Running Puppet"
pushd ${hostdir}
/usr/bin/puppet apply -l /var/log/puppet/site.log site.pp
popd

echo "Done with INIT."
