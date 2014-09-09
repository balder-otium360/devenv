# Install utilities
class devenv::utils (
  $chrome,
  $dropbox,
  $vim,
  $yakuake,
  $puppet_lint,
  $sublime_text,
  $unrar,
  ) {

  if $chrome {
    package { ['google-chrome-stable', 'google-talkplugin']:
      ensure  => latest,
    }
  }

  if $dropbox {
    package { 'dropbox' :
      ensure  => latest,
    }
  }

  if $vim {
    package { 'vim' :
      ensure  => latest,
    }
  }

  if $sublime_text {
    package { 'sublime-text-installer' :
      ensure => latest,
    }
  }

  if $yakuake {
    package { 'yakuake' :
      ensure  => latest,
    }
  }

  if $puppet_lint {
    include devenv::ruby

    package { 'puppet-lint' :
      ensure   => latest,
      provider => gem,
    }
  }

  if $unrar {
    package { 'unrar' :
      ensure  => latest,
    }
  }

}
