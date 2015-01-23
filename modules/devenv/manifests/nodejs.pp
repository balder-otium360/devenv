# Install NodeJS and global NPM modules
# TODO use nvm https://github.com/creationix/nvm
class devenv::nodejs (
  $version,
  $nvm,
  $nvm_version
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

  devenv::npm { 'bower' : }
  devenv::npm { 'grunt-cli' :
    creates => 'grunt'
  }
  devenv::npm { 'cordova' : }
  devenv::npm { 'ionic' : }
  devenv::npm { 'yo' : }

  if $nvm {

    $nvm_install = 'nvm-install.sh'
    $nvm_dir = "${devenv::home}/.nvm"

    wget::fetch { 'nvm':
      source      => "https://raw.githubusercontent.com/creationix/nvm/${nvm_version}/install.sh",
      destination => "${devenv::downloads}/${nvm_install}",
      execuser    => $devenv::user,
    }
    file { "${devenv::downloads}/${nvm_install}" :
      ensure => file,
      mode   => '0744',
      owner  => $devenv::user,
      group  => $devenv::user,
    }
    exec { 'install nvm' :
      command     => "${devenv::downloads}/${nvm_install}",
      user        => $devenv::user,
      environment => "HOME=${devenv::home}",
      unless      => "test -d ${nvm_dir}",
      require     => File["${devenv::downloads}/${nvm_install}"],
    }
  }

}
