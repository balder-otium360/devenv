# Install Compass
class devenv::compass {
  include devenv::ruby

  devenv::gem { 'compass' : }

}
