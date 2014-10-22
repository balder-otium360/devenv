# Install WebStorm
class devenv::webstorm (
  $version
) {

  $file    = "WebStorm-${version}"
  $dir     = $file
  $home    = "${devenv::development}/${dir}"
  $tgz     = "${file}.tar.gz"
  $url     = "http://download.jetbrains.com/webstorm/${tgz}"

  wget::fetch { 'webstorm':
    source      => $url,
    destination => "${devenv::downloads}/${tgz}",
    execuser    => $devenv::user,
  }

  exec { 'untar webstorm' :
    command => "tar xzf ${devenv::downloads}/${tgz} -C /tmp",
    user    => $devenv::user,
    unless  => "test -d ${home}",
    require => Wget::Fetch['webstorm'],
  }

  exec { 'mv webstorm' :
    command => "mv /tmp/WebStorm* ${home}",
    user    => $devenv::user,
    unless  => "test -d ${home}",
    require => Exec['untar webstorm'],
  }

  file { 'link webstorm' :
    ensure  => link,
    path    => "${devenv::development}/webstorm",
    target  => $home,
    owner   => $devenv::user,
    group   => $devenv::user,
    require => Exec['mv webstorm'],
  }

  devenv::desktopentry { 'webstorm' :
    iconFile      => "${devenv::development}/webstorm/bin/webide.png",
    iconExtension => 'png',
    require       => File['link webstorm'],
  }

}
