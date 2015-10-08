class Workshop < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: :user_id
  has_and_belongs_to_many :timeslots
  has_many :workshop_choices, dependent: :delete_all

  validates :title, :description, :timeframe, presence: true, unless: :helper_shift?
  validates :timeframe, numericality: { greater_than: 0 }, unless: :helper_shift?
  validates :max_tn, numericality: { greater_than: 0, allow_blank: true }, unless: :helper_shift?
  validate :numericality_of_price, unless: :helper_shift?

  scope :regular,      -> { where(helper_shift: false) }
  scope :helper_shift, -> { where(helper_shift: true) }
  scope :visible,      -> { where('visible OR helper_shift') }

  def human_trainers
    trainers.empty? ? (owner.try(:displayname) || '') : trainers
  end

  def multiple_trainers?
    @multiple_trainers ||= !! (human_trainers =~ /,|(und)|&|;/)
  end

  def training_registrations
    registrations = []
    if trainers.empty?
      # trainer == owner: add each payed registration to workshop
      registrations = owner.registrations.payed
    else
      # take trainers from workshop.trainers field
      registrations = ButRegistration.payed.where("position(trim(both from name) in ?) > 0", trainers)
    end
    registrations
  end

  # owner was previously 'user'
  def user
    owner
  end

  def numericality_of_price
    return if price.nil? || price.empty?
    begin
      Float(price.gsub(',', '.'))
    rescue
      errors.add(:price, "ist keine Zahl!")
    end
  end

  def spaces_left
    return Float::INFINITY if max_tn.nil?
    max_tn - workshop_choices.final_participants.count
  end

  def oneline_summary
    "#{title} (#{timeframe} Minuten)"
  end
end
