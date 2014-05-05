# Sublime Text Puppet Module for Boxen

New home for [boxen/puppet-sublime_text_2](https://github.com/boxen/puppet-sublime_text_3) with versions as config options

[![Build Status](https://travis-ci.org/boxen/puppet-sublime_text.png?branch=master)](https://travis-ci.org/boxen/puppet-sublime_text)

Install [Sublime Text 3](http://www.sublimetext.com/3) or [Sublime Text 2](http://www.sublimetext.com/), a text-editor/IDE for Mac

## Usage

```puppet
# For the latest build of v3
include sublime_text
sublime_text::package { 'Emmet':
  source => 'sergeche/emmet-sublime'
}

# For the latest version of v2
include sublime_text::v2
sublime_text::v2::package { 'Emmet':
  source => 'sergeche/emmet-sublime'
}
```

## Required Puppet Modules

None.
