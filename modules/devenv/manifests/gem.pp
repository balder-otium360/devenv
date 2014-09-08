# Install a Ruby Gem
define devenv::gem (
  $gem = $name
) {

  exec { "gem install ${gem}" :
    command => "gem install ${gem}",
    unless  => "gem which ${gem}"
  }

}
