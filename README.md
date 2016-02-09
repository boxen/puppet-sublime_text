# Sublime Text Puppet Module for Boxen

New home for [boxen/puppet-sublime_text_2](https://github.com/boxen/puppet-sublime_text_2) with versions as config options

[![Build Status](https://travis-ci.org/boxen/puppet-sublime_text.svg?branch=master)](https://travis-ci.org/boxen/puppet-sublime_text)

Install [Sublime Text 3](http://www.sublimetext.com/3) or [Sublime Text 2](http://www.sublimetext.com/), a text-editor/IDE for Mac

## Usage

```puppet
# For the latest build of v3
include sublime_text
sublime_text::package { 'Emmet':
  source => 'sergeche/emmet-sublime'
}

# For a specific build of v3
class { 'sublime_text':
  build                  => '3083',
  package_control_ensure => '5643f4fa9a335a4591482a8ecdf6e0d7413fbaa1',
  package_control_source => 'wbond/package_control'
}

# For the latest version of v2
include sublime_text::v2
sublime_text::v2::package { 'Emmet':
  source => 'sergeche/emmet-sublime'
}

# For a specific version of v2
class { 'sublime_text::v2':
  version => '2.0.2',
}
```

## Required Puppet Modules

* `boxen`
* `stdlib`
* `repository`
