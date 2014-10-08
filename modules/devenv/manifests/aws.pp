# Install AWS CLI
class devenv::aws (
) {

  $file    = 'awscli'
  $dir     = "${devenv::development}/${file}"
  $home    = $dir
  $zip     = "${file}-bundle.zip"
  $url     = "https://s3.amazonaws.com/aws-cli/${zip}"

  wget::fetch { 'awscli' :
    source      => $url,
    destination => "${devenv::downloads}/${zip}",
    execuser    => $devenv::user,
  }

  exec { 'unzip awscli' :
    command => "unzip -o ${devenv::downloads}/${zip} -d /tmp",
    user    => $devenv::user,
    unless  => "test -d ${dir}",
    require => Wget::Fetch['awscli'],
  }

  exec { 'install awscli' :
    command => "/tmp/awscli-bundle/install -i ${dir} -b ${devenv::home}/.local/bin/aws",
    user    => $devenv::user,
    unless  => "test -d ${dir}",
    require => Exec['unzip awscli'],
  }

  file_line { 'path awscli' :
    path => "${devenv::home}/.profile",
    line => "export PATH=\"${devenv::home}/.local/bin:\$PATH\"",
  }

  file_line { 'autocomplete awscli' :
    path => "${devenv::home}/.profile",
    line => "complete -C '${dir}/bin/aws_completer' aws",
  }

}
