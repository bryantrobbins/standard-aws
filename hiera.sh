#!/bin/bash

# Take in yaml as argument
hyaml=$1

# If no yaml input, exit without any further output
if [ -z ${hyaml} ]; then
  exit 0
fi

# Convert file to base 64
base64 $hyaml
