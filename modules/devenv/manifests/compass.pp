# Install Compass
class devenv::compass {
  include devenv::ruby

  package { 'compass' :
      ensure   => latest,
      provider => gem,
    }

}
