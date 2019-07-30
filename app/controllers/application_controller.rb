class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Paginate
  include JsonapiErrors # ALIAS JE

  rescue_from ::StandardError, with: ->(e) { handle_error(e) }

  self.responder = JsonApiResponder

  respond_to :json

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name locale])
  end
end
