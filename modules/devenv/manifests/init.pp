#######################################################
#
# All class parameters injected using conf/hiera/*.yaml
#
#######################################################
class devenv(
  $user,
  $home,
  $development,
  $downloads,
  $company
) {

  if $::operatingsystem != 'Ubuntu' {
    fail('Ubuntu is the only supported OS')
  }

  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/']
  }

  notice('                                                                    ')
  notice(' *****************************************************************  ')
  notice(' *        Puppet Configuration                                   *  ')
  notice(' *****************************************************************  ')
  notice(" *              confdir = ${settings::confdir}                      ")
  notice(" *               vardir = ${settings::vardir}                       ")
  notice(" *               ssldir = ${settings::ssldir}                       ")
  notice(" *           modulepath = ${settings::modulepath}                   ")
  notice(" *             factpath = ${settings::factpath}                     ")
  notice(' *****************************************************************  ')
  notice('                                                                    ')
  notice(' *****************************************************************  ')
  notice(' *        otium360 devenv Configuration                          *  ')
  notice(' *****************************************************************  ')
  notice(" *                 User = ${user}                                   ")
  notice(" *             Home dir = ${home}                                   ")
  notice(" *      Development dir = ${development}                            ")
  notice(" *        Downloads dir = ${downloads}                              ")
  notice(" *              Company = ${company}                                ")
  notice(' *****************************************************************  ')
  notice('                                                                    ')

  stage { 'preconfigure' :
    before => Stage['main']
  }

  class { 'devenv::aptsources' :
    stage => preconfigure
  }

  class { 'devenv::dirs' :
    stage => preconfigure
  }

  include devenv::android
  include devenv::compass
  include devenv::git
  include devenv::java
  include devenv::maven
  include devenv::mongodb
  include devenv::nginx
  include devenv::nodejs
  include devenv::ruby
  include devenv::sts
  include devenv::utils
  include devenv::virtualbox
  include devenv::vagrant

}
