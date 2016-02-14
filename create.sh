#!/bin/bash

# Get options
tname="../cloud.json"
tfile="$(cd "$(dirname "${tname}")"; pwd)/$(basename "${tname}")"
kname="builder"

# Delete old keypair
aws ec2 delete-key-pair --key-name ${kname}

# Create and save EC2 key pair
aws ec2 create-key-pair --key-name ${kname} --output text | sed 's/.*BEGIN.*-$/-----BEGIN RSA PRIVATE KEY-----/' | sed "s/.*${kname}$/-----END RSA PRIVATE KEY-----/" > ${kname}.pem
chmod 600 ${kname}.pem

# Create stack
aws cloudformation create-stack --stack-name BTR-standard --template-body file:///${tfile} --parameters ParameterKey=KeyName,ParameterValue=${kname} --capabilities CAPABILITY_IAM
