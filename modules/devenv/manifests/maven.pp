# Install Maven and provide basic configuration
class devenv::maven (
  $version
) {

  $file    = "apache-maven-${version}"
  $dir     = "${devenv::development}/${file}"
  $home    = "${devenv::development}/apache-maven-3"
  $tgz     = "${file}-bin.tar.gz"
  $url     = "http://ftp.cixug.es/apache/maven/maven-3/${version}/binaries/${tgz}"

  wget::fetch { 'maven' :
    source      => $url,
    destination => "${devenv::downloads}/${tgz}",
    execuser    => $devenv::user,
  }

  exec { 'untar maven' :
    command => "tar xzf ${devenv::downloads}/${tgz} -C ${devenv::development}",
    user    => $devenv::user,
    unless  => "test -d ${dir}",
    require => Wget::Fetch['maven'],
  }

  file { 'link maven' :
    ensure  => link,
    path    => $home,
    target  => $dir,
    owner   => $devenv::user,
    group   => $devenv::user,
    require => Exec['untar maven'],
  }


  file_line { 'm2_home' :
    path => "${devenv::home}/.profile",
    line => "export M2_HOME=\"${home}\"",
  }

  file_line { 'm2' :
    path    => "${devenv::home}/.profile",
    line    => 'export M2="$M2_HOME/bin"',
    require => File_Line['m2_home'],
  }

  file_line { 'm2_path' :
    path    => "${devenv::home}/.profile",
    line    => 'export PATH="$M2:$PATH"',
    require => File_Line['m2'],
  }

  file_line { 'm2_opts' :
    path => "${devenv::home}/.profile",
    line => 'export MAVEN_OPTS="-Xmx512m"',
  }

}
