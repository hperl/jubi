module Registerable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :person

    validates :user, :person, presence: true
    validate  :person_belongs_to_same_user
  end

  def person_belongs_to_same_user
    if user != person.user
      errors.add(:person, :invalid)
    end
  end
end
