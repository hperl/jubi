require 'rails_helper'

describe ConferenceRegistrationsController do
  context "logged in user" do
    login_user

    describe "GET new" do
      it "sets the person" do
        get 'new'
        registration = assigns(:conference_registration)
        expect(registration.person).to be_a(Person)
      end
    end
  end
end
