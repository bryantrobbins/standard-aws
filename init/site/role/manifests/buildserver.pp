class role::buildserver {
  include profile::builds
  include profile::proxy
  include profile::db
}
