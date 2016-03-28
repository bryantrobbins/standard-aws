class profile::builds {
  include superbuilds

  ::consul::service { 'jenkins':
    checks  => [
      {
        script   => '/usr/bin/curl localhost:8080',
        interval => '10s'
      }
    ],
    port    => 8080,
    tags    => ['build']
  }

}
