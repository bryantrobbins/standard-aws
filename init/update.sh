#!/bin/bash -v

echo "Running r10k"
pushd /root/init
/usr/local/bin/r10k puppetfile install -v debug &> r10k.log

echo "Running Puppet"
puppet apply site.pp --hiera_config hiera.yaml --modulepath=modules:site &> puppet.log
popd
