# Install NodeJS and global NPM modules
class devenv::nodejs (
  $version = 'v0.10.31'
) {

  $file    = "node-${version}-linux-x64"
  $tgz     = "${file}.tar.gz"
  $dir     = "${devenv::development}/${file}"
  $home    = "${devenv::development}/nodejs"
  $url     = "http://nodejs.org/dist/${version}/${tgz}"

  File['link nodejs'] -> Devenv::Npm<||>

  wget::fetch { $file :
    source      => $url,
    destination => "${devenv::downloads}/${tgz}",
    execuser    => $devenv::user,
  }

  exec { 'untar nodejs' :
    command => "tar xzf ${devenv::downloads}/${tgz} -C ${devenv::development}",
    user    => $devenv::user,
    unless  => "test -d ${dir}",
    require => Wget::Fetch[$file],
  }

  file { 'link nodejs' :
    ensure  => link,
    path    => $home,
    target  => $dir,
    owner   => $devenv::user,
    group   => $devenv::user,
    require => Exec['untar nodejs'],
  }

  file_line { 'nodejs_home' :
    path => "${devenv::home}/.profile",
    line => "export NODEJS_HOME=\"${home}\"",
  }

  file_line { 'nodejs_path' :
    path    => "${devenv::home}/.profile",
    line    => 'export PATH="$NODEJS_HOME/bin:$PATH"',
    require => File_Line['nodejs_home'],
  }

  devenv::npm { 'grunt-cli' :
    creates => 'grunt'
  }

  devenv::npm { 'bower' : }

  devenv::npm { 'yo' : }

}
