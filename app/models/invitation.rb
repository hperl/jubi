class Invitation < ActiveRecord::Base
  self.primary_key = :id
  belongs_to :group
  validates :email, presence: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  }, on: :create
  validates :group_id, presence: true
  validates :id, presence: true

  after_create :send_email
  before_validation :generate_id

  attr_reader :email_addresses

  def send_email
    InvitationMailer.invite(self).deliver
  end

  def generate_id
    s = ""
    r = Random.new
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    20.times { s << chars[r.rand(chars.length)] }
    self.id = s
  end
end
