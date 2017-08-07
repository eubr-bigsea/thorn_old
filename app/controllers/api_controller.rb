class ApiController < ApplicationController
  before_action :disable_devise_trackable

  # Shared JSON API render methods.
  protected


  private

  # Disable Devise Trackable for all API requests
  # Devise Trackable still tracks login since Devise is hooked to ApplicationController.
  def disable_devise_trackable
    request.env["devise.skip_trackable"] = true
  end
end
