class UsersAbility < BaseAbility
  def initialize(user, _params)
    can :manage, User if user.is_admin?
    if user.is_monitor?
      can :manage, User do |u|
        !u.is_admin?
      end
    end

    can :me, :all
    can :available, :all
  end
end
