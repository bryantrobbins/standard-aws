class profile::buildserver {
  include superbuilds
  class { 'nginx': }
  class { '::consul':
    config_hash => {
      'bootstrap_expect' => 1,
      'data_dir'         => '/opt/consul',
      'datacenter'       => 'primary',
      'log_level'        => 'INFO',
      'node_name'        => 'server',
      'server'           => true,
    }
  }
}
