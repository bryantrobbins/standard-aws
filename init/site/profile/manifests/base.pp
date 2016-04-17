class profile::base {
  class { '::ntp': }
  class { '::aws_ec2_facts': }
	
	package { 'java-1.7.0':
		ensure => absent,
	}

}
