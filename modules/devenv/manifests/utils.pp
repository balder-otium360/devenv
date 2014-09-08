# Install utilities
class devenv::utils (
  $chrome       = false,
  $dropbox      = false,
  $vim          = true,
  $yakuake      = false,
  $puppet_lint  = false,
  $sublime_text = false,
  $unrar        = false
  ) {

  if $chrome {
    package { ['google-chrome-stable', 'google-talkplugin']:
      ensure  => latest
    }
  }

  if $dropbox {
    package { 'dropbox' :
      ensure  => latest
    }
  }

  if $vim {
    package { 'vim' :
      ensure  => latest
    }
  }

  if $sublime_text {
    package { 'sublime-text-installer' :
      ensure => latest
    }
  }

  if $yakuake {
    package { 'yakuake' :
      ensure  => latest
    }
  }

  if $puppet_lint {
    devenv::gem { 'puppet-lint' : }
  }

  if $unrar {
    package { 'unrar' :
      ensure  => latest
    }
  }

}
