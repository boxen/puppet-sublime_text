require 'spec_helper'

describe 'sublime_text::v2' do
  let(:version) { '2.0.2' }
  let(:boxenhome) { '/test/boxen' }
  let(:repodir) { "#{boxenhome}/repo" }
  let(:boxenuser) { 'testuser' }
  let(:packagedir) { "/Users/#{boxenuser}/Library/Application Support/Sublime Text 2/Packages" }
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
      should contain_package("Sublime Text 2-#{version}").with({
        :ensure   => 'installed',
        :name     => 'Sublime Text 2',
        :provider => 'appdmg',
        :source   => 'https://download.sublimetext.com/' +
                        "Sublime%20Text%20#{version}.dmg"
      })
    end
  end

  context "custom params" do
    let(:params) {
      {
        :version => '2.1.2',
        :preferences => 'spec/fixtures/sublime-settings.json'
      }
    }
    it do
      should contain_package('Sublime Text 2-2.1.2').with({
        :ensure      => 'installed',
        :name        => 'Sublime Text 2',
        :provider    => 'appdmg',
        :source      => 'https://download.sublimetext.com/' +
                        'Sublime%20Text%202.1.2.dmg'
      })

      should contain_file("#{packagedir}/User").with({
        :ensure => 'directory',
        :mode   => '0755',
        :owner  => "#{boxenuser}",
      }).that_requires("Package[Sublime Text 2-2.1.2]")

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
        :ensure  => 'directory',
        :mode    => '0755',
        :owner   => "#{boxenuser}",
      }).that_requires("Package[Sublime Text 2-#{version}]")

      should contain_file("#{packagedir}/User/Preferences.sublime-settings").with({
        :source => 'spec/fixtures/sublime-settings.json',
      }).that_requires("File[#{packagedir}/User]")
    end
  end
end
