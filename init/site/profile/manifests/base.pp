class profile::base {
  class { '::ntp': }
  class { '::aws_ec2_facts': }
}
