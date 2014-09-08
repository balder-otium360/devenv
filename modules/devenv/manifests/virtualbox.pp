# Install Oracle VirtualBox
class devenv::virtualbox (
  $version
) {

  package { ["virtualbox-${version}", 'dkms'] :
    ensure => latest
  }

}
