require 'spec_helper'

describe 'sublime_text' do
  let(:build) { '3114' }
  let(:boxenhome) { '/test/boxen' }
  let(:repodir) { "#{boxenhome}/repo" }
  let(:boxenuser) { 'testuser' }
  let(:packagedir) { "/Users/#{boxenuser}/Library/Application Support/Sublime Text 3/Packages" }
  let(:facts) do
    default_test_facts.merge({
      :boxen_home    => boxenhome,
      :boxen_repodir => repodir,
      :boxen_user    => boxenuser,
      :luser         => boxenuser,
    })
  end

  context "default params" do
    it do
      should contain_package("Sublime Text-Build-#{build}").with({
        :ensure   => 'installed',
        :name     => 'Sublime Text',
        :provider => 'appdmg',
        :source   => 'https://download.sublimetext.com/' +
                        "Sublime%20Text%20Build%20#{build}.dmg"
      })

      should contain_repository("#{packagedir}/Package Control").with({
        :ensure => '5643f4fa9a335a4591482a8ecdf6e0d7413fbaa1',
        :source => 'wbond/package_control'
      }).that_requires("Package[Sublime Text-Build-#{build}]")
    end
  end

  context "custom params" do
    let(:params) {
      {
        :build                  => '8888',
        :package_control_ensure => 'v1.2.2',
        :package_control_source => 'custom/package_control',
        :preferences            => 'spec/fixtures/sublime-settings.json'
      }
    }
    it do
      should contain_package('Sublime Text-Build-8888').with({
        :ensure   => 'installed',
        :name     => 'Sublime Text',
        :provider => 'appdmg',
        :source   => 'https://download.sublimetext.com/' +
                        'Sublime%20Text%20Build%208888.dmg'
      })

      should contain_repository("#{packagedir}/Package Control").with({
        :ensure => 'v1.2.2',
        :source => 'custom/package_control'
      }).that_requires('Package[Sublime Text-Build-8888]')

      should contain_file("#{packagedir}/User").with({
        :ensure => 'directory',
        :mode   => '0755',
        :owner  => "#{boxenuser}",
      }).that_requires('Package[Sublime Text-Build-8888]')

      should contain_file("#{packagedir}/User/Preferences.sublime-settings").with({
        :ensure => 'link',
        :target => 'spec/fixtures/sublime-settings.json',
      }).that_requires("File[#{packagedir}/User]")
    end
  end

  context "custom params II" do
    let(:params) {
      {
        :preferences => 'spec/fixtures/sublime-settings.json',
        :symlink     => false
      }
    }
    it do
      should contain_file("#{packagedir}/User").with({
        :ensure => 'directory',
        :mode   => '0755',
        :owner  => "#{boxenuser}",
      }).that_requires("Package[Sublime Text-Build-#{build}]")

      should contain_file("#{packagedir}/User/Preferences.sublime-settings").with({
        :source => 'spec/fixtures/sublime-settings.json',
      }).that_requires("File[#{packagedir}/User]")
    end
  end
end
