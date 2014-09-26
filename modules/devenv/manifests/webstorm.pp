# Install WebStorm
class devenv::webstorm (
  $version
) {

  $file    = "WebStorm-${version}"
  $dir     = $file
  $tgz     = "WebStorm-${version}.tar.gz"
  $url     = "http://download-cf.jetbrains.com/webstorm/${tgz}"

  wget::fetch { 'webstorm':
    source      => $url,
    destination => "${devenv::downloads}/${tgz}",
    execuser    => $devenv::user,
  }

  exec { 'untar webstorm' :
    command => "tar xzf ${devenv::downloads}/${tgz} -C ${devenv::development}",
    user    => $devenv::user,
    unless  => "find ${devenv::development} -name 'WebStorm*'",
    require => Wget::Fetch['webstorm'],
  }

}
