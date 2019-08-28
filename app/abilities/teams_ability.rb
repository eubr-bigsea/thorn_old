class TeamsAbility < BaseAbility
  def initialize(user, _params)
    can :manage, :all
  end
end
