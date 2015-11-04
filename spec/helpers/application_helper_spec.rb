require 'spec_helper'
require 'pry'

describe ApplicationHelper do
  describe '#switch_language_url' do
    context 'development environment' do
      before { Rails.env = 'development' }
      after  { Rails.env = 'test' }
      subject { switch_language_url('http://a/b') }

      context 'current locale is german' do
        before { I18n.locale = :de }
        it { is_expected.to eq('http://a/b?locale=en') }
      end

      context 'current locale is english' do
        before { I18n.locale = :en }
        it { is_expected.to eq('http://a/b?locale=de') }
      end
    end

    context 'production environment' do
      before { Rails.env = 'production' }
      after  { Rails.env = 'test' }
      subject { switch_language_url('http://some.host/some/url') }

      context 'current locale is german' do
        before { I18n.locale = :de }
        it { is_expected.to eq('https://60years.yfu.de/some/url') }
      end

      context 'current locale is english' do
        before { I18n.locale = :en }
        it { is_expected.to eq('https://60jahre.yfu.de/some/url') }
      end
    end
  end
end

