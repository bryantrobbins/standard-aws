My standard AWS setup for side projects

A simple set of scripts (mostly from AWS Cloudformation examples) for bringing up an AWS Infrastructure (VPC, Subnet, Network Routes, etc.) and my standard set of Internet-facing instances.

Currently just brings up a single instance in the VPC, with a Jenkins master and build tools installed.

# Usage

Create an AWS account, and install the AWS CLI, through one of the methods mentioned [here](http://docs.aws.amazon.com/cli/latest/userguide/installing.html).

Create a User in your AWS account, with full Admin capabilities. Download the credentials for this user (this will produce a file credentials.csv).

From the root directory of this project, run the following to set up your AWS CLI calls.

```
./setcredentials.sh /path/to/credentials.csv
```

From the root directory of this project, run the following to create a CloudFormation stack with all resources:

```
./create.sh
```

A file builder.pem will be produced during the execution of create.sh. IMPORTANT: Copy this file to somewhere else (such as your home directory) to ensure that it does not accidentally get checked in to any code paths (assuming, for example, that you forked this repository into one of your own).

In the top-level AWS Console, navigate to the CloudFormation console, and follow the creation of resources in the "Events" tab of your newly created stack. When done, check the Outputs tab for the following:

* Jenkins URL: A Public URL for the Jenkins UI hosted on the BuildHost
* SSHCommand: A sample command for SSHing into the BuildHost
* SCPCommand: A sample command for SCPing the builder.pem file into the BuildHost (e.g., for the purposes of SSHing into ECS slaves)

