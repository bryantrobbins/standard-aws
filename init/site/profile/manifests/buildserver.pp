class profile::buildserver {
  include superbuilds
  include consul_template

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

  consul_template::watch { 'baseball':
    template      => 'files/baseball.json.ctmpl',
    destination   => '/etc/nginx/conf.d/baseball.conf',
    command       => '/etc/init.d/nginx reload',
  }
}
