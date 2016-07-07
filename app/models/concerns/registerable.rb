module Registerable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :person

    validates :user, :person, presence: true
    validate  :person_belongs_to_same_user

    enum state: %w(unpayed payed cancelled cancelled_without_costs)
  end

  def person_belongs_to_same_user
    return if person.nil?

    if user != person.user
      errors.add(:person, :invalid)
    end
  end
end
