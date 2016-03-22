require 'rails_helper'

RSpec.describe "profiles/show", type: :view do
  it 'renders' do
    allow(view).to receive_messages(:current_user => User.new)
    render template: 'profiles/show'
  end
end
