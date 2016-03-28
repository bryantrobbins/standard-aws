class profile::proxy (
  $backends = hiera('profile::proxy::backends'),
  $frontends = hiera('profile::proxy::frontends'),
  $domain = hiera('profile::proxy::domain')
) {
  class { 'nginx': }

  class { '::consul':
    config_hash => {
      'data_dir'   => '/opt/consul',
      'datacenter' => 'primary',
      'log_level'  => 'INFO',
      'node_name'  => 'agent',
      'retry_join' => [$aws_cloudformation_buildserver_privateip],
    }
  }
  
  class { 'consul_template':
    manage_user  => true,
    manage_group => true,
  }

  $backends.each | $backend | {
    $service = $backend['service']
    $port = $backend['port']
    $route = $backend['route']

    consul_template::watch { "$service":
      template      => 'profile/backend.json.ctmpl.erb',
      template_vars => {
        'service' => "$service",
        'port' => "$port",
        'route' => "$route",
        'domain' => "$domain",
      },
      destination   => "/etc/nginx/conf.d/${service}.conf",
      command       => '/etc/init.d/nginx reload',
    }
  }

  $frontends.each | $frontend | {
    $service = $frontend['service']
    $port = $frontend['port']

    consul_template::watch { "$service":
      template      => 'profile/frontend.json.ctmpl.erb',
      template_vars => {
        'service' => "$service",
        'port' => "$port",
        'backends' => $backends,
      },
      destination   => "/etc/nginx/conf.d/${service}.conf",
      command       => '/etc/init.d/nginx reload',
    }
  }
}
