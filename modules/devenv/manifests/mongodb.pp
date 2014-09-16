# Install MongoDB and Robomongo
class devenv::mongodb (
  $robomongo_version
) {

  $robomongo_deb     = "robomongo-${robomongo_version}.deb"
  $robomongo_url     = "http://robomongo.org/files/linux/${robomongo_deb}"

  package { 'mongodb-org' :
    ensure => latest
  }

  wget::fetch { 'robomongo':
    source      => $robomongo_url,
    destination => "${devenv::downloads}/${robomongo_deb}",
    execuser    => $devenv::user,
  }

  package { 'robomongo' :
    ensure   => latest,
    provider => dpkg,
    source   => "${devenv::downloads}/${robomongo_deb}",
    require  => Wget::Fetch['robomongo'],
  }

}
