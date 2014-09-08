# Install nginx
class devenv::nginx {

  package { 'nginx' :
    ensure  => latest
  }

}
