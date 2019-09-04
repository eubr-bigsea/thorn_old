class RolesAbility < BaseAbility
  def initialize(user, _params)
    can :index, :all

    if user.is_admin?
      can :manage, :all
    elsif user.is_manager?
      can :add_monitor, Role
      can :remove_monitor
    end
  end
end
