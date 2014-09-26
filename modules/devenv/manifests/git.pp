# Git SCM, plugins and GitHub SSH configuration
class devenv::git(
  $smartgit,
  $smartgit_version,
  $home,
  $user_email,
  $user_name,
  $core_editor,
  $github_user,
  $github_ssh_pswd,
  $github_ssh_keys = false,
) {

  notice('                                                                    ')
  notice(' *****************************************************************  ')
  notice(' *          Git Configuration                                    *  ')
  notice(' *****************************************************************  ')
  notice(" *             SmartGit = ${smartgit}                               ")
  notice(" *         Git home dir = ${home}                                   ")
  notice(" *            Git email = ${user_email}                             ")
  notice(" *             Git name = ${user_name}                              ")
  notice(" *           Git editor = ${core_editor}                            ")
  notice(" *          GitHub user = ${github_user}                            ")
  notice(" *      GitHub SSH keys = ${github_ssh_keys}                        ")
  notice(' *****************************************************************  ')
  notice('                                                                    ')

  package { ['git', 'git-flow'] :
    ensure  => latest
  }

  file { $home :
    ensure => directory,
    mode   => '0755',
    owner  => $devenv::user,
    group  => $devenv::user,
  }

  file { "${devenv::home}/.gitconfig" :
    ensure  => present,
    content => template('devenv/.gitconfig.erb'),
    mode    => '0644',
    owner   => $devenv::user,
    group   => $devenv::user,
  }

  if $smartgit {

    $smartgithg_file = "smartgithg-${smartgit_version}"
    $smartgithg_dir  = "${devenv::development}/${smartgithg_file}"
    $smartgithg_tgz  = "smartgithg-generic-${smartgit_version}.tar.gz"
    $smartgithg_url  = "http://www.syntevo.com/download/smartgithg/${smartgithg_tgz}"

    wget::fetch { 'smartgithg':
      source      => $smartgithg_url,
      destination => "${devenv::downloads}/${smartgithg_tgz}",
      execuser    => $devenv::user,
    }

    exec { 'untar smartgithg' :
      command => "tar xzf ${devenv::downloads}/${smartgithg_tgz} -C ${devenv::development}",
      user    => $devenv::user,
      unless  => "test -d ${smartgithg_dir}",
      require => Wget::Fetch['smartgithg'],
    }

    file { 'link smartgithg' :
      ensure  => link,
      path    => "${devenv::development}/smartgithg",
      target  => $smartgithg_dir,
      owner   => $devenv::user,
      group   => $devenv::user,
      require => Exec['untar smartgithg'],
    }
  }

  if $github_ssh_keys {
    $github_keygen_home = "${home}/github-keygen"

    vcsrepo { $github_keygen_home :
      ensure   => latest,
      provider => git,
      source   => 'https://github.com/dolmen/github-keygen.git',
      revision => 'release',
      owner    => $devenv::user,
      group    => $devenv::user,
      require  => [File[$home], Package['git']]
    }

    $ssh_home = "${devenv::home}/.ssh"

    exec { 'github_keygen' :
      command     => "${github_keygen_home}/github-keygen ${github_user} -p ${github_ssh_pswd}",
      user        => $devenv::user,
      environment => "HOME=${home}",
      unless      => "test -f ${ssh_home}/id_${github_user}@github",
      require     => Vcsrepo[$github_keygen_home]
    }

    file { 'known_hosts' :
      ensure  => present,
      path    => "${ssh_home}/known_hosts",
      source  => "${ssh_home}/known_hosts_github",
      mode    => '0644',
      owner   => $devenv::user,
      group   => $devenv::user,
      require => Exec['github_keygen']
    }
  }
}
