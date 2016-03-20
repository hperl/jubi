class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    # rights for all (incl. guests)
    can :read, Workshop

    # rights for registered users
    unless user.new_record?
      # can create new workshop/regsitration, manage own
      can :create, [Workshop, ConferenceRegistration, PartyRegistration]
      can :crud, Workshop, owner: user
      can :manage, [ConferenceRegistration, PartyRegistration], user: user
      can :remember, Workshop
      can :read, Payment

      can :create, Group
      can :leave,  Group
      can :read,   Group, "id IN [#{user.group_ids.join(', ')}]" do |group|
        group.users.include? user
      end
      can :manage, Group, owner: user

      # can manage self
      can :manage, User, id: user.id
    end

    # kernteam rights => all
    if user.kernteam?
      can :manage, :but_board
      can :create, Payment, responsible_user: user
      can :manage, Workshop
      can :read, Payment
    end
  end
end
