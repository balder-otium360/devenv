# Install Docker
class devenv::docker {

  package { 'lxc-docker' :
    ensure  => latest,
  }

  exec { "usermod -a -G docker ${devenv::user}" :
    require => Package['lxc-docker'],
  }

}
