# Install Sublime Text into /Applications
#
# Usage:
#
#     include sublime_text
class sublime_text(
  $build = '3083',
  $package_control_ensure = '5643f4fa9a335a4591482a8ecdf6e0d7413fbaa1',
  $package_control_source = 'wbond/package_control'
) {
  require sublime_text::config

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
}

