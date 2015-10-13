require 'spec_helper'
require 'pry'

describe ApplicationHelper do
  describe '#switch_language_url' do
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
end

