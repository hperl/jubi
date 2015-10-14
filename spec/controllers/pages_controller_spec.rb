require 'rails_helper'

describe PagesController do
  describe "localization" do
    context "no locale set in params" do
      before { get :show, id: 'index' }
      it "defaults to german locale" do
        expect(I18n.locale).to eq(:de)
      end
    end

    context "locale set to english in params" do
      before { get :show, id: 'index', locale: 'en' }
      it "sets english locale" do
        expect(I18n.locale).to eq(:en)
      end
    end
  end
end
