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
  $company,
  $android,
  $aws,
  $compass,
  $docker,
  $git,
  $idea,
  $java,
  $maven,
  $mongodb,
  $nginx,
  $nodejs,
  $ruby,
  $sts,
  $utils,
  $vagrant,
  $virtualbox,
  $webstorm,
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
  notice(' *****************************************************************  ')
  notice(' *        otium360 devenv Installed Software                     *  ')
  notice(' *****************************************************************  ')
  notice(" *          Android SDK = ${android}                                ")
  notice(" *              AWS CLI = ${aws}                                    ")
  notice(" *              Compass = ${compass}                                ")
  notice(" *               Docker = ${docker}                                 ")
  notice(" *         Git (+tools) = ${git}                                    ")
  notice(" *                 IDEA = ${idea}                                   ")
  notice(" *                 Java = ${java}                                   ")
  notice(" *                Maven = ${maven}                                  ")
  notice(" *     MongoDB (+tools) = ${mongodb}                                ")
  notice(" *                nginx = ${nginx}                                  ")
  notice(" *    NodeJS (+modules) = ${nodejs}                                 ")
  notice(" *                 Ruby = ${ruby}                                   ")
  notice(" *    Spring Tool Suite = ${sts}                                    ")
  notice(" *                utils = ${utils}                                  ")
  notice(" *              Vagrant = ${vagrant}                                ")
  notice(" *          Virtual Box = ${virtualbox}                             ")
  notice(" *             WebStorm = ${webstorm}                               ")
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

  if $android {
    include devenv::android
  }
  if $aws {
    include devenv::aws
  }
  if $compass {
    include devenv::compass
  }
  if $docker {
    include devenv::docker
  }
  if $git {
    include devenv::git
  }
  if $idea {
    include devenv::idea
  }
  if $java {
    include devenv::java
  }
  if $maven {
    include devenv::maven
  }
  if $mongodb {
    include devenv::mongodb
  }
  if $nginx {
    include devenv::nginx
  }
  if $nodejs {
    include devenv::nodejs
  }
  if $ruby {
    include devenv::ruby
  }
  if $sts {
    include devenv::sts
  }
  if $utils {
    include devenv::utils
  }
  if $vagrant {
    include devenv::vagrant
  }
  if $virtualbox {
    include devenv::virtualbox
  }
  if $webstorm {
    include devenv::webstorm
  }

}
