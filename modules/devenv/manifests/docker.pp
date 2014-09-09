# Install Docker
class devenv::docker {

  package { 'docker.io' :
    ensure  => latest,
  }

  file { 'link docker' :
    ensure  => link,
    path    => '/usr/local/bin/docker',
    target  => '/usr/bin/docker.io',
    owner   => root,
    group   => root,
    require => Package['docker.io'],
  }

}
