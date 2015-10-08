class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible_user, class_name: User

  validates :amount, presence: true, numericality: true
  validate :user_present
  validates :responsible_user, presence: true

  after_save :mark_users_but_registrations_as_payed

  def amount
    amount_in_cents.to_d / 100
  end

  def amount=(money)
    self.amount_in_cents = money.to_d * 100
  end

  protected
  def user_present
    unless self.user
      errors.add(:user_id, "konnte keinen Benutzer mit der ID #{user_id} finden")
    end
  end

  def mark_users_but_registrations_as_payed
    user.mark_registrations_as_payed
  end
end
