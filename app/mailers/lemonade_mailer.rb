class LemonadeMailer < Devise::Mailer

  default template_path: 'lemonade_mailer'

  def reset_password_instructions(record, token, opts={})
    I18n.locale = record.locale.to_sym
    opts[:subject] = t('.subject')
    super
  end

end
