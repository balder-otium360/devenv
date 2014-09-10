# Configure APT repos and keys
class devenv::aptsources {

  include apt

  Apt::Key<||> -> Apt::Source<||>
  Apt::Key<||> -> Apt::Ppa<||>

  apt::ppa { 'ppa:git-core/ppa' : }
  apt::ppa { 'ppa:webupd8team/java' : }
  apt::ppa { 'ppa:webupd8team/sublime-text-3' : }

  apt::key { 'virtualbox' :
    key        => '98AB5139',
    key_source => 'https://www.virtualbox.org/download/oracle_vbox.asc',
  }
  apt::source { 'virtualbox' :
    location    => 'http://download.virtualbox.org/virtualbox/debian',
    release     => 'trusty',
    repos       => 'contrib',
    include_src => false,
  }

  apt::key { 'mongodb' :
    key        => '7F0CEB10',
    key_server => 'keyserver.ubuntu.com',
  }
  apt::source { 'mongodb' :
    location    => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart',
    release     => 'dist',
    repos       => '10gen',
    include_src => false,
  }

  apt::key { 'nginx' :
    key        => '7BD9BF62',
    key_source => 'http://nginx.org/keys/nginx_signing.key',
  }
  apt::source { 'nginx' :
    location    => 'http://nginx.org/packages/mainline/ubuntu',
    release     => 'trusty',
    repos       => 'nginx',
    include_src => false,
  }

  apt::key { 'google' :
    key        => '7FAC5991',
    key_source => 'https://dl-ssl.google.com/linux/linux_signing_key.pub',
  }
  apt::source { 'google_chrome' :
    location    => 'http://dl.google.com/linux/chrome/deb',
    release     => 'stable',
    repos       => 'main',
    include_src => false,
  }
  apt::source { 'google_talkplugin' :
    location    => 'http://dl.google.com/linux/talkplugin/deb',
    release     => 'stable',
    repos       => 'main',
    include_src => false,
  }

  apt::key { 'dropbox' :
    key        => '5044912E',
    key_server => 'pgp.mit.edu',
  }
  apt::source { 'dropbox' :
    location    => 'http://linux.dropbox.com/ubuntu',
    release     => 'trusty',
    repos       => 'main',
    include_src => false,
  }

  apt::key { 'docker' :
    key        => 'A88D21E9',
    key_server => 'keyserver.ubuntu.com',
  }
  apt::source { 'docker' :
    location    => 'https://get.docker.io/ubuntu',
    release     => 'docker',
    repos       => 'main',
    include_src => false,
  }

}
