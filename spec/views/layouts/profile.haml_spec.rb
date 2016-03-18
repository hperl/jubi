require 'rails_helper'

RSpec.describe "layouts/profile", type: :view do
  context "registered user" do
    it 'renders' do
      allow(view).to receive_messages(:current_user => User.new)
      render template: 'layouts/profile'
    end
  end
end
