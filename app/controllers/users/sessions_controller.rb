class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_request!, only: [:create, :destroy]

  def new
    if user = User.find_for_database_authentication(email: params[:email])
      if user.valid_password?(params[:password])
        user.update_attribute(:remember, params[:remember])
        @current_user = user
        sign_in @current_user
        render json: get_token(@current_user)
      else
        render json: {errorMessage: 'Invalid Password', code: 1, success: false}, status: :unauthorized
      end
    else
      render json: {errorMessage: 'Invalid email', code: 2, success: false}, status: :unauthorized
    end
  end

  def create
    render json: @current_user.as_json.except(:created_at, :updated_at, :id)
  end

  def destroy
  end

  private

  def get_token user
    return nil unless user&.id
    user_info = user.as_json.except('created_at','updated_at')
    user_info['last_sign_in_at'] = user.last_sign_in_at
    { auth_token: JsonWebToken.encode({user: user_info})  }
  end

  def get_info token
    return nil unless token
    JsonWebToken.decode(token)
  end
end
