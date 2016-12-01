class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: User.find(params[:id])
  end
end
