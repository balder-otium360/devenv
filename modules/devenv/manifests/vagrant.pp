# Install Vagrant
class devenv::vagrant (
  $version
) {

  include devenv::virtualbox

  $deb     = "vagrant_${version}.deb"
  $url     = "https://dl.bintray.com/mitchellh/vagrant/${deb}"

  wget::fetch { 'vagrant':
    source      => $url,
    destination => "${devenv::downloads}/${deb}",
    execuser    => $devenv::user,
  }

  package { 'vagrant' :
    ensure   => installed,
    provider => dpkg,
    source   => "${devenv::downloads}/${deb}",
    require  => Wget::Fetch['vagrant'],
  }

}
