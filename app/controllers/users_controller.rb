class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[confirm show update destroy]
  has_scope :search_by
  has_scope :sorted_by

  def index
    @users = apply_scopes(User).all

    paginate @users, UserSerializer
  end

  def show
    render json: UserSerializer.new(@user)
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation_notification!
    @user.save!

    render json: UserSerializer.new(@user), status: :created
  end

  def update
    @user.update!(user_params)

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
end
