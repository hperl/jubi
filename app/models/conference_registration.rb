class ConferenceRegistration < ActiveRecord::Base
  include Registerable

  validate :arrival_before_departure
  validate :arrival_not_too_early
  validate :departure_not_too_late

  validates :arrival, :departure, presence: true

  enum diet: %w(eats_everything vegetarian vegan lactose_free other_diet)
  enum accomodation: %w(acc_dorm acc_dorm_with_bath acc_double acc_family acc_single acc_none)
  enum room_mates:
    %w(room_mates_none room_mates_group room_mates_other_registrations)
  enum sex: %w(sex_other sex_male sex_female)

  private
  def arrival_before_departure
    if arrival > departure
      errors.add(:arrival, :arrival_before_departure)
    end
  end

  def arrival_not_too_early
    if arrival < Settings.dates.conference_start
      errors.add(:arrival, :arrival_too_early)
    end
  end

  def departure_not_too_late
    if departure > Settings.dates.conference_end
      errors.add(:departure, :departure_too_late)
    end
  end
end
