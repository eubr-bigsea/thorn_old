class RolesAbility < BaseAbility
  def initialize(user, _params)
    can :add_admin, Role if user.is_admin?
    can :me, :all
  end
end
