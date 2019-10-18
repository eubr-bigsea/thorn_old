class LemonadeMailer < Devise::Mailer
  default template_path: 'lemonade_mailer'

  def reset_password_instructions(record, token, opts = {})
    I18n.locale = record.locale.to_sym
    opts[:subject] = t('.subject')
    super
  end

  def confirmation_instructions(record, token, opts = {})
    I18n.locale = record.locale.to_sym
    opts[:subject] = t('.subject')
    super
  end

  def unlock_instructions(record, token, opts = {})
    I18n.locale = record.locale.to_sym
    opts[:subject] = t('.subject')
    super
  end

  def user_registration_notification(record, user, opts = {})
    I18n.locale = record.locale.to_sym
    opts[:subject] = t('.subject')
    @staff = record
    @new_user = user
    @url = Rails.application.config.action_mailer.default_url_options[:host]
    devise_mail(record, :user_registration_notification, opts)
  end
end
