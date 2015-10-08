class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :registrations, class: ButRegistration
  has_many :payments
  has_many :workshops
  has_many :payments_responsible_for, class_name: Payment
  has_and_belongs_to_many :groups
  has_many :owned_groups, class_name: Group, foreign_key: :owner_id

  serialize :remembered_workshop_ids, Array

  # if there are registrations, the displayname is the concatenation of the
  # names used to register. If they share a common family name it is included
  # only once for a shorter displayname
  def displayname
    case registrations.length
    when 0 then return email
    when 1 then return registrations.first.name
    else
      names = registrations.map {|r| r.name.split }
      if names.map {|n| n[1..-1]}.uniq.length == 1
        names = names[0..-2].map {|n| [n.first]} + [names[-1]]
      end
      names = names.map {|n| n.join(' ') }
      return names[0..-2].join(', ') + ' und ' + names[-1]
    end
  end

  def mark_registrations_as_payed
    if balance >= 0
      registrations.map do |r|
        if r.unpayed?
          # update and skip validation
          r.update_attribute('state', 'payed')
        end
      end
    end
  end

  def balance
    payments.map(&:amount).sum - registrations.map(&:price).sum
  end

  def transactions
    (payments + registrations).sort_by!(&:created_at).reverse!
  end

  def remembered?(workshop)
    remembered_workshop_ids.include? workshop.id
  end

  def discount_registration
    registrations.where("state NOT IN (?, ?)", ButRegistration.states[:cancelled], ButRegistration.states[:cancelled_without_costs]).order('id').first
  end

  def can_view_visible_registrations?
    registrations.any? {|r| r.visible?}
  end

  def offers_workshop?
    !workshops.empty?
  end

  def karma
    # only handle karma granted by user account here.
    # This applies to 'workshop owners', 'kernteam' and 'extended kernteam'
    karma = 0
    karma += Settings.karma.kernteam          if kernteam?
    karma += Settings.karma.extended_kernteam if extended_kernteam?
    karma += Settings.karma.workshop_owner    if offers_workshop?
    karma
  end
end
