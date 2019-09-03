class RolesController < ApplicationController
  load_and_authorize_resource

  before_action :set_role, only: %i[show update destroy]

  def index
    @roles = Role.all

    render json: @roles
  end

  def add_admin
    @user = User.find(admin_params)
    @user.add_role :admin

    render json: UserSerializer.new(@user), status: :created
  end

  def add_manager
    'a'
  end

  def add_monitor
    'a'
  end

  def remove_admin
    'a'
  end

  def remove_manager
    'a'
  end

  def remove_monitor
    'a'
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def admin_params
    params.require(:role).permit(:user_id)[:user_id]
  end
end
