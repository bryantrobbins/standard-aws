class profile::db (
  $password = hiera('profile::db::password'),
){

  class {'::mongodb::server':
    auth => true,
  }

  mongodb::db { 'testdb':
    user     => 'user1',
    password => $password,
  } 
}
