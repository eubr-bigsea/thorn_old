class UsersAbility < BaseAbility
  def initialize(user, _params)
    can :manage, User if user.is_admin?
  end
end
