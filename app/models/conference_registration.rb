class ConferenceRegistration < ActiveRecord::Base
  include Registerable

  validate :arrival_before_departure
  validate :arrival_not_too_early
  validate :departure_not_too_late

  validates :arrival, :departure, presence: true

  enum diet: %w(eats_everything vegetarian vegan lactose_free other_diet)
  enum room_mates:
    %w(room_mates_none room_mates_group room_mates_other_registrations)
  enum sex: %w(sex_other sex_male sex_female)


  def price
    Settings.prices.conference_registration
  end

  def accomodation=(new_accomodation)
    # just store the label of the accomodation
    write_attribute(:accomodation, new_accomodation.label)
  end

  def accomodation
    # return the class from the label
    label = read_attribute(:accomodation)
    return "Accomodation::#{label.classify}".constantize
  end

  private
  def arrival_before_departure
    return if arrival.nil? or departure.nil?

    if arrival > departure
      errors.add(:arrival, :arrival_before_departure)
    end
  end

  def arrival_not_too_early
    return if arrival.nil?

    if arrival < Settings.dates.conference_start
      errors.add(:arrival, :arrival_too_early)
    end
  end

  def departure_not_too_late
    return if departure.nil?

    if departure > Settings.dates.conference_end
      errors.add(:departure, :departure_too_late)
    end
  end
end
