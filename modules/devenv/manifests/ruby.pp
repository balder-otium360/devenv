# Install Compass
class devenv::ruby {

  package { 'ruby1.9.1-full' :
    ensure  => latest
  }

}
