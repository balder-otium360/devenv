# Install a NPM package globally to a given user
define devenv::npm (
  $package = $name,
  $creates = $name
) {

  exec { "npm install ${package}" :
    command => "${devenv::nodejs::home}/bin/npm install -g ${package}",
    user    => $devenv::user,
    creates => "${devenv::nodejs::home}/bin/${creates}"
  }

}
