class profile::proxy (
  $backend = hiera('profile::proxy::backends')
) {
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

  $backends.each |upstream| {
    consul_template::watch { "$upstream":
      template      => 'profile/backend.json.ctmpl.erb',
      destination   => "/etc/nginx/conf.d/${upstream}.conf",
      command       => '/etc/init.d/nginx reload',
    }
  }
}
