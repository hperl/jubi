# Base class for all accomodations
module Accomodation
  def all
    return [
      Accomodation::Dorm,
      Accomodation::DoubleRoom,
      Accomodation::SingleRoom
    ]
  end
  module_function :all

  class Base
    def self.price
      Settings.prices.rooms[self.label]
    end

    def self.label
      self.name.demodulize.underscore
    end
  end

  class DoubleRoom < Base; end
  class SingleRoom < Base; end
  class Dorm       < Base; end
end
