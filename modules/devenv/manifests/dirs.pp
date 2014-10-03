# Create required directories
class devenv::dirs {

  file { $devenv::development :
    ensure => directory,
    mode   => '0755',
    owner  => $devenv::user,
    group  => $devenv::user,
  }

  file { $devenv::downloads :
    ensure => directory,
    mode   => '0755',
    owner  => $devenv::user,
    group  => $devenv::user,
  }

  file { "${devenv::home}/.local/share/icons" :
    ensure => directory,
    mode   => '0700',
    owner  => $devenv::user,
    group  => $devenv::user,
  }

}
