# Install Android SKD
class devenv::android (
  $version
) {

  $file    = "android-sdk_${version}"
  $home    = "${devenv::development}/android-sdk-linux"
  $tgz     = "${file}.tgz"
  $url     = "http://dl.google.com/android/${$tgz}"

  wget::fetch { 'android' :
    source      => $url,
    destination => "${devenv::downloads}/${tgz}",
    execuser    => $devenv::user,
  }

  exec { 'untar android' :
    command => "tar xzf ${devenv::downloads}/${tgz} -C ${devenv::development}",
    user    => $devenv::user,
    unless  => "test -d ${home}",
    require => Wget::Fetch['android'],
  }


  file_line { 'android_home' :
    path => "${devenv::home}/.profile",
    line => "export ANDROID_SDK_HOME=\"${home}\"",
  }

  file_line { 'android_path' :
    path    => "${devenv::home}/.profile",
    line    => 'export PATH="$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH"',
    require => File_Line['android_home'],
  }

}
