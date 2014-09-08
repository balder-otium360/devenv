# Install Java JDKs
class devenv::java (
  $oracle_java7,
  $oracle_java8
) {

  if $oracle_java7 {
    file { 'java7.seeds' :
      ensure => present,
      path   => '/var/cache/debconf/java7.seeds',
      source => 'puppet:///modules/devenv/java7.seeds',
      owner  => root,
      group  => root,
      mode   => '0644'
    }

    package { ['oracle-java7-installer', 'oracle-java7-set-default'] :
      ensure       => latest,
      responsefile => '/var/cache/debconf/java7.seeds',
      require      => File['java7.seeds'],
    }
  }

  if $oracle_java8 {
    file { 'java8.seeds' :
      ensure => present,
      path   => '/var/cache/debconf/java8.seeds',
      source => 'puppet:///modules/devenv/java8.seeds',
      owner  => root,
      group  => root,
      mode   => '0644'
    }

    package { 'oracle-java8-installer' :
      ensure       => latest,
      responsefile => '/var/cache/debconf/java8.seeds',
      require      => File['java8.seeds'],
    }
  }

}
