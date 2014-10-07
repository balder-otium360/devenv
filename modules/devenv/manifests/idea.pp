# Install Idea
class devenv::idea (
  $version
) {

  $file    = "ideaIU-${version}"
  $dir     = $file
  $home    = "${devenv::development}/${dir}"
  $tgz     = "${file}.tar.gz"
  $url     = "http://download-cf.jetbrains.com/idea/${tgz}"

  wget::fetch { 'idea':
    source      => $url,
    destination => "${devenv::downloads}/${tgz}",
    execuser    => $devenv::user,
  }

  exec { 'untar idea' :
    command => "tar xzf ${devenv::downloads}/${tgz} -C /tmp",
    user    => $devenv::user,
    unless  => "test -d ${home}",
    require => Wget::Fetch['idea'],
  }

  exec { 'mv idea' :
    command => "mv /tmp/idea-IU* ${home}",
    user    => $devenv::user,
    unless  => "test -d ${home}",
    require => Exec['untar idea'],
  }

  file { 'link idea' :
    ensure  => link,
    path    => "${devenv::development}/idea",
    target  => $home,
    owner   => $devenv::user,
    group   => $devenv::user,
    require => Exec['mv idea'],
  }

  devenv::desktopentry { 'idea' :
    iconFile      => "${devenv::development}/idea/bin/idea.png",
    iconExtension => 'png',
    require       => File['link idea'],
  }

}
