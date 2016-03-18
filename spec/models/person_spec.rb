require 'rails_helper'

RSpec.describe Person, type: :model do
  subject do
    Person.new(
      user: User.new,
      name: "person",
      address: "Foo 12345",
      nickname: nil,
      visible: true,
      age: 18,
    )
  end

  describe "valid person" do
    it { should be_valid }
    it { should be_visible }
  end

  describe "unnamed person" do
    before { subject.name = "" }
    it { should_not be_valid }
  end

  describe "invalid age" do
    before { subject.age = -1 }
    it { should_not be_valid }
  end
end
