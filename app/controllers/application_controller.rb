# Application Controller: User Authentication from token control
# + CSRF protection for all Devise requests.
class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  respond_to :json
  before_action :authenticate_user_from_token!


  protected

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
end
