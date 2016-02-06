require 'spec_helper'

describe 'sublime_text::v2' do
  let(:facts) { 
    {
      :boxen_home => "/test/boxen",
      :boxen_user => "testuser",
    }
  }

  context "default params" do
    it do
      should contain_package('Sublime Text 2-2.0.2').with({
        :ensure   => 'installed',
        :name     => 'Sublime Text 2',
        :provider => 'appdmg',
        :source   => 'https://download.sublimetext.com/' +
                        'Sublime%20Text%202.0.2.dmg'
      })
    end
  end

  context "custom params" do
    let(:params) {
      { 
        :version => '2.1.2'
      }
    }
    it do
      should contain_package('Sublime Text 2-2.1.2').with({
        :ensure   => 'installed',
        :name     => 'Sublime Text 2',
        :provider => 'appdmg',
        :source   => 'https://download.sublimetext.com/' +
                        'Sublime%20Text%202.1.2.dmg'
      })
    end
  end
end
