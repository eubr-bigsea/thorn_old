class NotifyAdminsNewUserJob < ApplicationJob
  queue_as :default

  def perform(resource)
    User.with_role(:admin).each do |user|
      LemonadeMailer.user_registration_notification(user, resource).deliver
    end
  end
end
