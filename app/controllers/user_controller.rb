class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: @current_user.as_json
  end
end
