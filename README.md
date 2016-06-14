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

# You can create your user preferences file (default creates a symlink to your file)
class { 'sublime_text':
  preferences => "${::boxen_home}/repo/modules/people/files/${::github_login}/sublime-settings.json",
  symlink     => false
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

## Hiera configuration

The following variables may be automatically overridden with Hiera:

``` yaml
---

# define build of sublime text 3
sublime_text::build: '3083'

# install packages for sublime text 3...
sublime_text::packages:
  'Emmet':
    source: 'sergeche/emmet-sublime'
  'HTML5':
    source: 'mrmartineau/HTML5'

# ...or for sublime text v2
sublime_text::v2::packages:
  'Emmet':
    source: 'sergeche/emmet-sublime'

# you can also define the version for sublime text v2
sublime_text::v2::version: '2.0.2'

# or you can set your user preferences file just like this
sublime_text::preferences: "%{::boxen_home}/repo/modules/people/files/%{::github_login}/sublime-settings.json"

The module checks if the file exists. So you can define this globally in your common.yaml for all of your team members and if the file exists in the file folder of that team member, the module creates a symlink to this file an you can track all user changes in your version control of boxen. 

```

## Required Puppet Modules

* `boxen`
* `stdlib`
* `repository`
