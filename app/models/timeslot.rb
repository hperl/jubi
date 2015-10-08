class Timeslot < ActiveRecord::Base
  has_and_belongs_to_many :workshops
  has_and_belongs_to_many :but_registrations
  enum kind: %w(meal workshop plenum social other helper_shift tournament)

  def selected_by_user?(user)
    user.registrations.joins(:helper_shift_timeslots).where(but_registrations_timeslots: {timeslot_id: id}).count > 0
  end

  def selected_by_registration?(registration)
    but_registrations.exists? registration.id
  end

  def current_tn
    but_registrations.count
  end

  def missing_tn
    [max_tn - current_tn].max
  end

  def overlaps?(other)
    (self.start+1.second..self.end).overlaps?(other.start+1.second..other.end)
  end
end
