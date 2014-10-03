# Install Oracle VirtualBox
class devenv::virtualbox (
  $version
) {

  package { 'dkms' :
    ensure => latest,
  }

  package { "virtualbox-${version}" :
    ensure  => latest,
    require => Package['dkms'],
  }

}
