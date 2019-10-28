class TeamsAbility < BaseAbility
  def initialize(user, _params)
    can :manage, :all if user.is_admin?
  end
end
