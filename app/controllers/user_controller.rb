class UserController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    render json: User.find(params[:id])
  end

  def validate_token
    @user = User.find(params[:id])
    if @user && @user.valid_token?(params['access-token'], params[:client])
      render json: @user
    else
      render json: { message: 'token not valid' }, status: :unprocessable_entity
    end
  end
end
