require 'spec_helper'

describe 'sublime_text' do
  let(:facts) { 
    {
      :boxen_home => '/test/boxen',
      :boxen_user => 'testuser',
      :luser      => 'testuser'
    }
  }
  context "default params" do
    it do
      should contain_package('Sublime Text-Build-3083').with({
        :ensure   => 'installed',
        :name     => 'Sublime Text',
        :provider => 'appdmg',
        :source   => 'https://download.sublimetext.com/' +
                        'Sublime%20Text%20Build%203083.dmg'
      })

      should contain_repository('/Users/testuser/Library/Application Support/Sublime Text 3/Packages/Package Control').with({
        :ensure  => '5643f4fa9a335a4591482a8ecdf6e0d7413fbaa1',
        :source  => 'wbond/package_control'
      }).that_requires('Package[Sublime Text-Build-3083]')
    end
  end

  context "custom params" do
    let(:params) {
      { 
        :build                  => '8888',
        :package_control_ensure => 'v1.2.2',
        :package_control_source => 'custom/package_control'
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

      should contain_repository('/Users/testuser/Library/Application Support/Sublime Text 3/Packages/Package Control').with({
        :ensure => 'v1.2.2',
        :source => 'custom/package_control'
      }).that_requires('Package[Sublime Text-Build-8888]')
    end
  end
end
