class WorkshopChoice < ActiveRecord::Base
  belongs_to :workshop
  belongs_to :but_registration

  enum choice_type: %w(first_choice second_choice third_choice)

  scope :final,  -> { where(final: true) }
  scope :choice, -> { where(final: false) }
  scope :final_participants, -> { where('final = true AND (trainer = false OR trainer IS NULL)') }
  scope :final_trainers, -> { where(final: true, trainer: true) }
end
