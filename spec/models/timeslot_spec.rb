require 'rails_helper'

RSpec.describe Timeslot do
  describe "#open_end?" do
    context "Timeslot goes till 23:59" do
      subject { Timeslot.new(end: DateTime.parse('2017-06-18  23:59 +0200')).open_end? }

      it "should be open ended" do
        is_expected.to be true
      end
    end
    context "Timeslot goes till 23:58" do
      subject { Timeslot.new(end: DateTime.parse('2017-06-18  23:58 +0200')).open_end? }

      it "should not be open ended" do
        is_expected.to be false
      end
    end

    context "Timeslot goes till 20:59" do
      subject { Timeslot.new(end: Time.parse('2017-06-18  20:59 +0200')).open_end? }

      it "should not be open ended" do
        is_expected.to be false
      end
    end

    context "New timeslot" do
      subject { Timeslot.new.open_end? }

      it "should not be open ended" do
        is_expected.to be false
      end
    end
  end
end
