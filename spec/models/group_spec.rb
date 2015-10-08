require 'spec_helper'

describe Group do
  describe "generate_password" do
    subject(:group) { Group.new }

    it "generates a new password" do
      group.generate_password
      group.password.should_not be_nil
      group.password.should_not be_empty
    end

    it "does not overwrite a password" do
      group.generate_password
      pw = group.password
      group.generate_password
      group.password.should == pw
    end
  end
end
