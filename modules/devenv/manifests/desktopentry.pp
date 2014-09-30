# Install a desktop entry and icon
define devenv::desktopentry (
  $iconFile,
  $iconExtension,
  $desktopFile = "${devenv::home}/.local/share/applications/${name}.desktop"
) {

  file { "launcher ${name}" :
    ensure  => present,
    path    => $desktopFile,
    content => template("devenv/${name}.desktop.erb"),
    mode    => '0644',
    owner   => $devenv::user,
    group   => $devenv::user,
  }

  file { "launcher icon ${name}" :
    ensure => present,
    path   => "${devenv::home}/.local/share/icons/${name}.${iconExtension}",
    source => $iconFile,
    mode   => '0644',
    owner  => $devenv::user,
    group  => $devenv::user,
  }

}
