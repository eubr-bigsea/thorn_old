# Application Controller: User Authentication from token control
# + CSRF protection for all Devise requests.
class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  respond_to :json
  before_action :set_locale
  before_action :authenticate_user_from_token!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:password, keys: [:email])
    devise_parameter_sanitizer.permit(:reset_password, keys: [:email, :password, :password_confirmation, :reset_password_token])
  end

  # Login User from token if there is one present on the Header.
  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, token)
        @user = user
        sign_in @user, store: false
      else
        render json: {errors: [{detail: "email and token validation failed", source: "data/attributes/email"},{detail: "email and token validation failed", source: "data/attributes/token"}]}, status: 404
      end
    end
  end

  def set_locale
    begin
      I18n.locale = request.headers["locale"]
    rescue
      I18n.locale = :en
    end
  end
end
