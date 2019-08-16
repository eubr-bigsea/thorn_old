class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Paginate
  include JsonapiErrors # ALIAS JE

  rescue_from ::StandardError, with: ->(e) { 
    puts '**********************************'
    puts e
    puts '**********************************'

    handle_error(e) }
  rescue_from CanCan::AccessDenied do |_e|
    error = Errors::Unauthorized.new(message: 'You don\'t has access level to this action.')
    handle_error(error)
  end

  self.responder = JsonApiResponder

  respond_to :json

  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  check_authorization unless: :devise_controller?

  def current_ability
    @current_ability ||= BaseAbility.build(current_user, controller_name, params)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name locale])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name locale])
  end

  def set_locale
    I18n.locale = request.headers['locale'].nil? ? :en : request.headers['locale']
  end
end
