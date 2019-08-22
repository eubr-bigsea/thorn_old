class ProjectsAbility < BaseAbility
  def initialize(user, _params)
    can :manage, Project if user.is_admin?

    can :show, Project do |project|
      user.has_role? :manager, project
    end
  end
end
