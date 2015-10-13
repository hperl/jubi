require 'rails_helper'
require 'pry'

RSpec.describe ButRegistration, :type => :model do
  context "registration is not frozen" do
    before { Settings.dates.registrations_frozen = Time.now + 1.year }

    context "cancelled registration" do
      it "should not be able to update" do
        reg = ButRegistration.create!({name: "bla", address: "12345", sex: 0, age: 100, t_shirt_size: "Männerschnitt S"})
        reg.name = 'Max'
        reg.should be_valid
        reg.cancel
        reg.name = 'BLUB'
        reg.should_not be_valid
      end
    end
  end
end
