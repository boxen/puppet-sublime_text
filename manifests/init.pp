# Install Sublime Text into /Applications
#
# Usage:
#
#     include sublime_text
class sublime_text($build = '3065') {
  require sublime_text::config

  package { 'Sublime Text':
    provider => 'appdmg',
    source   => "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%20${build}.dmg";
  }

  file { "${boxen::config::bindir}/subl":
    ensure  => link,
    target  => '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl',
    mode    => '0755',
    require => Package['Sublime Text'],
  }

  repository { "${sublime_text::config::packagedir}/Package Control":
    ensure  => '6a8b91ca58d66cb495b383d9572bb801316bcec5',
    source  => 'wbond/sublime_package_control',
    require => Package['Sublime Text']
  }
}

