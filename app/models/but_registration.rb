#encoding: utf-8

class ButRegistration < ActiveRecord::Base
  HELP_AREAS = %w(freestyler checkin party kiosk grillen ersthelfer)

  belongs_to :user
  belongs_to :accomodation_group, class_name: 'Group'
  has_many :workshop_choices, dependent: :delete_all
  has_many :chosen_workshops, through: :workshop_choices, class_name: 'Workshop', source: 'workshop'
  has_and_belongs_to_many :helper_shift_timeslots, class_name: 'Timeslot'

  before_save :set_accomodation_to_family, if: :toddler?

  enum diet:   %w(eats_everything vegetarian vegan lactose_free other_diet)
  enum estimated_checkin_day:   %w(checkin_do checkin_fr checkin_sa checkin_so)
  enum estimated_checkout_day:  %w(checkout_do checkout_fr checkout_sa checkout_so)
  enum estimated_checkin_time:  (9..23).map {|i| 'checkin_' + i.to_s}
  enum estimated_checkout_time: (9..23).map {|i| 'checkout_' + i.to_s}
  enum accomodation: %w(acc_dorm acc_dorm_with_bath acc_double acc_family acc_single acc_none)
  enum room_mates:
    %w(room_mates_none room_mates_group room_mates_other_registrations)
  enum sex: %w(sex_male sex_female sex_other)
  enum state: %w(unpayed payed cancelled cancelled_without_costs)
  enum lg: %w(keine Berlin Bayern Brandenburg-Mecklenburg-Vorpommern Main-Rhein-Saar Hamburg Mitteldeutschland Nord-West Niedersachsen-Hannover Rheinland Schleswig-Holstein Südwest Westfalen)
  enum transportation: %w(other_transportation public_transportation car)

  # Also change #votable?
  scope :votable, -> { where('state = ? OR created_at > ?', ButRegistration::states['payed'], Settings.dates.votable_without_payment) }

  T_SHIRT_SIZES = { "Kindergrößen" => [
                      "Kindergröße 104",
                      "Kindergröße 116",
                      "Kindergröße 128",
                      "Kindergröße 140",
                      "Kindergröße 152",
                      "Kindergröße 164",
                      "Kindergröße 152",
                      "Kindergröße 152"],

                  "Frauenschnitte" => [
                    "Frauenschnitt XS",
                    "Frauenschnitt S",
                    "Frauenschnitt M",
                    "Frauenschnitt L",
                    "Frauenschnitt XL",
                    "Frauenschnitt XXL"],

                    "Männerschnitte" => [
                      "Männerschnitt S",
                      "Männerschnitt M",
                      "Männerschnitt L",
                      "Männerschnitt XL",
                      "Männerschnitt XXL",
                      "Männerschnitt 3XL",
                      "Männerschnitt 4XL",
                      "Männerschnitt 5XL"]}

  %w(estimated_checkin_days estimated_checkout_days
     estimated_checkin_times estimated_checkout_times
     accomodations room_mates).each do |enum|
    self.define_singleton_method('t_' + enum) do |t|
      self.send(enum).to_a.map {|e| [e.first, t(e.first)]}
    end
  end

  validates_presence_of :name, :address, :sex, :age
  validates :age, numericality:
    { greater_or_equal_to: 0, only_integer: true }
  validate :stays_at_least_one_day
  validates :address, format: /\d{5}/
  validate :correct_t_shirt_size
  validate :not_cancelled
  validate :not_frozen

  def correct_t_shirt_size
    if !toddler?
      if !(t_shirt_size.present?) || !(T_SHIRT_SIZES.values.flatten.include? t_shirt_size)
        errors.add(:t_shirt_size, 'Du musst eine T-Shirt-Größe wählen')
      end
    end
  end

  def not_cancelled
    if cancelled? || cancelled_without_costs?
      errors[:base] << "Stornierte Anmeldung kann nicht bearbeitet werden."
    end
  end

  def not_frozen
    if frozen?
      errors[:base] << "Die Bearbeitung der BUT-Anmeldungen ist jetzt gesperrt."
    end
  end

  # set as cancelled and skip validation
  def cancel
    if payed?
      self.state = 'cancelled'
    elsif unpayed?
      self.state = 'cancelled_without_costs'
    end
    save(validate: false)
  end

  def choice_for_workshop(workshop)
    @grouped_workshop_choices ||= workshop_choices.where(final: false).group_by(&:workshop_id)
    @grouped_workshop_choices[workshop.id].try(:first)
  end

  def final_choice_for_workshop(workshop)
    @grouped_final_workshop_choices ||= workshop_choices.where(final: true).group_by(&:workshop_id)
    @grouped_final_workshop_choices[workshop.id].try(:first)
  end

  def toddler?
    age && age < 3
  end

  def days
    read_attribute(:estimated_checkout_day) - read_attribute(:estimated_checkin_day) + 1
  end

  def kernteam?
    return false unless user
    user.kernteam? && user.discount_registration == self
  end

  def extended_kernteam?
    return false unless user
    user.extended_kernteam? && user.discount_registration == self
  end

  def offers_workshop?
    return false unless user
    !user.workshops.empty?
  end

  def registration_price
    if acc_none?
      return Settings.prices.first_day + Settings.prices.other_days * (days-1)
    end
    (kernteam? || extended_kernteam?) ? Settings.prices.registration * 0.5 : Settings.prices.registration
  end

  def room_prices
    p = Settings.prices.rooms.to_h
    p = p.each {|k,v| p[k] = v * 0.5} if kernteam? || extended_kernteam?
    return Config::Options.new(p)
  end

  def distance_prices
    return 0 if acc_none?
    p = Settings.prices.distances.to_h
    p = p.each {|k,v| p[k] = v * 0.0} if kernteam?
    p = p.each {|k,v| p[k] = v * 0.5} if extended_kernteam?
    return Config::Options.new(p)
  end

  def early_bird_price
    if is_early_bird?
      (kernteam? || extended_kernteam?) ? Settings.prices.early_bird * 0.5 : Settings.prices.early_bird
    else
      0
    end
  end

  def price
    price = registration_price +
      room_prices[accomodation] +
      distance_prices[distance_category] +
      early_bird_price
    if toddler? || cancelled_without_costs?
      price = 0
    else
      if cancelled?
        if updated_at < Settings.dates.early_bird_registration_passed
          price = 5
        elsif updated_at > DateTime.parse('2015-03-01 00:00 +0200')
          price *= 0.5
        else
          price *= 0.2
        end
      end
    end
    price
  end

  def amount
    -price
  end

  def distance_category
    Settings.categories[plz_area]
  end

  def plz_area
    md = /(\d{2})\d{3}/.match address
    if md
      return md[1].to_i
    end
  end

  def description
    "BUT-Anmeldung (#{days-1} Nächte im #{accomodation})"
  end

  def room_mates_text
    %w(room_mates_none room_mates_group room_mates_other_registrations)
    if room_mates_none?
      return "egal"
    end
    if room_mates_group?
      return "Gruppe #{accomodation_group.try(:name)}"
    end
    if room_mates_other_registrations?
      return "mit " + user.registrations.reject {|r| r == self}.map(&:name).join(', ')
    end
    # should never reach this
    return ""
  end

  def stays_at_least_one_day
    unless days > 0
      errors[:base] << "Du musst mindestens einen Tag am BUT teilnehmen"
    end
  end

  def wants_to_help
    [wants_to_help_checkin,
     wants_to_help_freestyler,
     wants_to_help_party,
     wants_to_help_kiosk].any?
  end

  def karma
    Rails.cache.fetch("#{cache_key}/karma") do
      return 0 if toddler?
      karma = 0
      # registrations inherit the karma of the user
      karma += user.karma # / user.registrations.payed.where('age >= 3').count
      # number of workshops trained
      karma += Settings.karma.workshop_owner if co_offers_workshop?
      # number of helper shift the registration signed up for
      karma += Settings.karma.helper_shift * helper_shift_timeslots.count
      # the number of helper shift workshop voted at first place
      karma += Settings.karma.helper_shift * workshop_choices.first_choice.where(final: false).joins(:workshop).where(workshops: {helper_shift: true}).count
      karma
    end
  end

  # true if either user offers a workshop or trains one
  def offers_workshop?
    user.offers_workshop? || !Workshop.where('trainers ILIKE :name', name: "%#{name}%").empty?
  end

  # only true iff does not offer own workshop but trains one
  def co_offers_workshop?
    !user.offers_workshop? && !Workshop.where('trainers ILIKE :name', name: "%#{name}%").empty?
  end

  def training_workshops
    user_ws = user.workshops.where(trainers: '')
    reg_ws = Workshop.where('trainers ILIKE :name', name: "%#{name}%")
    user_ws + reg_ws
  end

  def helps?
    helper_shift_timeslots.count > 0 || workshop_choices.first_choice.where(final: false).joins(:workshop).where(workshops: {helper_shift: true}).count > 0
  end

  def help_areas
    res = []
    ButRegistration::HELP_AREAS.each do |area|
      if self.send("wants_to_help_#{area}")
        res << area
      end
    end
    return res
  end

  # returns true if user can't edit the registration any more
  def frozen?
    Time.now > Settings.dates.registrations_frozen
  end

  # also change scope :votable
  def votable?
    payed? || created_at > Settings.dates.votable_without_payment
  end

  private
  def set_accomodation_to_family
    self.accomodation = 'acc_family'
  end
end
