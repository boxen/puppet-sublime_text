# Install Sublime Text into /Applications
#
# Usage:
#
#     include sublime_text
class sublime_text(
  $build                  = '3114',
  $package_control_ensure = '5643f4fa9a335a4591482a8ecdf6e0d7413fbaa1',
  $package_control_source = 'wbond/package_control',
  $preferences            = undef,
  $packages               = undef,
  $symlink                = true,
) {
  require sublime_text::config

  $_symlink = $symlink ? {
    undef   => false,
    default => $symlink,
  }

  package { "Sublime Text-Build-${build}":
    ensure   => installed,
    name     => 'Sublime Text',
    provider => 'appdmg',
    source   => "https://download.sublimetext.com/Sublime%20Text%20Build%20${build}.dmg";
  }

  file { "${boxen::config::bindir}/subl":
    ensure  => link,
    target  => '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl',
    mode    => '0755',
    require => Package["Sublime Text-Build-${build}"],
  }

  repository { "${sublime_text::config::packagedir}/Package Control":
    ensure  => $package_control_ensure,
    source  => $package_control_source,
    require => Package["Sublime Text-Build-${build}"]
  }

  if file_exists($preferences) {
    file { "${sublime_text::config::packagedir}/User":
      ensure  => 'directory',
      owner   => $::boxen_user,
      mode    => '0755',
      require => Package["Sublime Text-Build-${build}"],
    }

    if $_symlink {
      file { "${sublime_text::config::packagedir}/User/Preferences.sublime-settings":
        ensure  => link,
        target  => $preferences,
        require => File["${sublime_text::config::packagedir}/User"]
      }
    }
    else {
      file { "${sublime_text::config::packagedir}/User/Preferences.sublime-settings":
        source  => $preferences,
        require => File["${sublime_text::config::packagedir}/User"]
      }
    }
  }

  if $packages {
    $_packages = $packages
  }
  else {
    $_packages = hiera_hash('sublime_text::packages', {})
  }

  validate_hash($_packages)
  create_resources('sublime_text::package', $_packages)
}

