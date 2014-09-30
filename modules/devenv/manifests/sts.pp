# Install Spring Tool Suite
class devenv::sts (
  $version
) {

  $file    = "sts-${version}"
  $dir     = $file
  $home    = "${devenv::development}/${dir}"
  $tgz     = "spring-tool-suite-${version}-e4.4-linux-gtk-x86_64.tar.gz"
  $url     = "http://download.springsource.com/release/STS/3.6.1/dist/e4.4/${tgz}"

  wget::fetch { 'sts':
    source      => $url,
    destination => "${devenv::downloads}/${tgz}",
    execuser    => $devenv::user,
  }

  exec { 'untar sts' :
    command => "tar xzf ${devenv::downloads}/${tgz} -C /tmp",
    user    => $devenv::user,
    unless  => "test -d ${home}",
    require => Wget::Fetch['sts'],
  }

  exec { 'mv sts' :
    command => "mv /tmp/sts-bundle/${dir} ${home}",
    user    => $devenv::user,
    unless  => "test -d ${home}",
    require => Exec['untar sts'],
  }

  file { 'link sts' :
    ensure  => link,
    path    => "${devenv::development}/sts",
    target  => $home,
    owner   => $devenv::user,
    group   => $devenv::user,
    require => Exec['mv sts'],
  }

  devenv::desktopentry { 'sts' :
    iconFile      => "${devenv::development}/sts/icon.xpm",
    iconExtension => 'xpm',
    require       => File['link sts'],
  }

  package { 'libwebkitgtk-1.0-0' :
    ensure  => latest
  }

}
