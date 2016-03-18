require 'rails_helper'

RSpec.describe PartyRegistration, type: :model do
  subject do
    user = User.new
    PartyRegistration.new(
      person: Person.new(user: user),
      user: user
    )
  end

  context "valid conference registration" do
    it { should be_valid }
  end

  context "person does not belong to same user" do
    before { subject.user = User.new }
    it { should_not be_valid }
  end
end
