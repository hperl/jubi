require 'rails_helper'

RSpec.describe "conference_registrations/new", type: :view do
  it 'renders' do
    assign :conference_registration, ConferenceRegistration.new(person: Person.new)
    allow(view).to receive_messages(current_user: User.new)
    render template: 'conference_registrations/new'
  end
end
