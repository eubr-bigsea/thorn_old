class BaseAbility
  include CanCan::Ability
  def self.build(user, controller, params)
    ability = (controller + '_ability').classify.to_s.constantize
    user ||= User.new
    params ||= {}
    ability.new(user, params)
  end
end
