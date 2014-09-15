# Install Docker
class devenv::docker {

  package { 'lxc-docker' :
    ensure  => latest,
  }

  exec { "usermod -a -G docker ${devenv::user}" :
    unless  => "grep -q 'docker.*${devenv::user}' /etc/group",
    require => Package['lxc-docker'],
  }

}
