# Install Sublime Text 2 into /Applications
#
# Usage:
#
#     include sublime_text::v2
class sublime_text::v2 (
  $version     = '2.0.2',
  $preferences = undef,
  $packages    = undef,
  $symlink     = true,
) {
  require sublime_text::v2::config

  $_symlink = $symlink ? {
    undef   => false,
    default => $symlink,
  }

  package { "Sublime Text 2-${version}":
    ensure   => installed,
    name     => 'Sublime Text 2',
    provider => 'appdmg',
    source   => "https://download.sublimetext.com/Sublime%20Text%20${version}.dmg";
  }

  file { "${boxen::config::bindir}/subl2":
    ensure  => link,
    target  => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl',
    mode    => '0755',
    require => Package["Sublime Text 2-${version}"],
  }

  if file_exists($preferences) {
    file { "${sublime_text::v2::config::packagedir}/User":
      ensure  => 'directory',
      owner   => $::boxen_user,
      mode    => '0755',
      require => Package["Sublime Text 2-${version}"],
    }

    if $_symlink {
      file { "${sublime_text::v2::config::packagedir}/User/Preferences.sublime-settings":
        ensure  => link,
        target  => $preferences,
        require => File["${sublime_text::v2::config::packagedir}/User"]
      }
    }
    else {
      file { "${sublime_text::v2::config::packagedir}/User/Preferences.sublime-settings":
        source  => $preferences,
        require => File["${sublime_text::v2::config::packagedir}/User"]
      }
    }
  }

  if $packages {
    $_packages = $packages
  }
  else {
    $_packages = hiera_hash('sublime_text::v2::packages', {})
  }

  validate_hash($_packages)
  create_resources('sublime_text::v2::package', $_packages)
}

