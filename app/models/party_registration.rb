class PartyRegistration < ActiveRecord::Base
  include Registerable

  def price
    Settings.prices.party_registration
  end
end
