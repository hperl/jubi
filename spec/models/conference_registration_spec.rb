require 'rails_helper'

RSpec.describe ConferenceRegistration, type: :model do
  subject do
    user = User.new
    ConferenceRegistration.new(
      arrival: Settings.dates.conference_start,
      departure: Settings.dates.conference_end,
      person: Person.new(user: user),
      user: user
    )
  end

  context "valid conference registration" do
    it { should be_valid }
  end

  context "arrival after departure" do
    before { subject.arrival = subject.departure + 1.hour }
    it { should_not be_valid }
  end

  context "arrival too early" do
    before { subject.arrival = Settings.dates.conference_start - 1.hour }
    it { should_not be_valid }
  end

  context "departure too early" do
    before { subject.departure = Settings.dates.conference_end + 1.hour }
    it { should_not be_valid }
  end

  context "person does not belong to same user" do
    before { subject.user = User.new }
    it { should_not be_valid }
  end

  describe '#accomodation' do
    it 'serializes the accomodation in the db' do
      subject.accomodation = Accomodation::Dorm
      subject.save!
      expect(subject.accomodation).to be Accomodation::Dorm
    end
  end

  describe '#price_listing' do
    it 'returns a detailed listing of the subprices'
  end
end
