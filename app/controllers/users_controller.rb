class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[confirm show update destroy]
  has_scope :search_by
  has_scope :sorted_by, default: '{"confirmed_at":"asc"}'

  def index
    @users = if current_user.is_admin?
               apply_scopes(User).all
             else
               apply_scopes(User.without_role(:admin)).all
             end

    paginate @users, UserSerializer
  end

  def available
    render json: UserAvailableSerializer.new(apply_scopes(User).all)
  end

  def show
    render json: UserSerializer.new(@user)
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation_notification!
    @user.save!

    @user.add_role(role_param) if role_param

    render json: UserSerializer.new(@user), status: :created
  end

  def update
    @user.skip_password_validation = true
    @user.update!(user_params)

    if role_param
      @user.roles.destroy_all
      @user.add_role(role_param)
    end

    render json: UserSerializer.new(@user)
  end

  def destroy
    @user.destroy
  end

  def confirm
    @user.confirm
    @user.send_unlock_instructions

    render json: UserSerializer.new(@user)
  end

  def me
    render json: UserSerializer.new(current_user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :locale)
  end

  def role_param
    params[:user][:role] if current_user.is_admin?
  end
end
