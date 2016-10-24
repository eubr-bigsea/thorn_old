class HomeController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: {logged_in_as: @current_user.as_json}
  end
end
