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

  class { 'consul_template':
    manage_user  => true,
    manage_group => true,
  }

  consul_template::watch { 'baseball-ui':
    template      => 'profile/baseball-ui.json.ctmpl.erb',
    destination   => '/etc/nginx/conf.d/baseball-ui.conf',
    command       => '/etc/init.d/nginx reload',
  }
}
