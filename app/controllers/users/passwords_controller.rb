class Users::PasswordsController < Devise::PasswordsController
  def new
    if params[:email] and user = User.find_by(email: params[:email])
      token = user.send_reset_password_instructions
      user.update_attribute(:reset_password_token, token)
      user.save
      render json: { successMessage: 'Instructions sent to ' + params[:email], code: 5, success: true }
    else
      render json: { errorMessage: 'Invalid email', code: 2, success: false }, status: :unauthorized
    end
  end

  def create
    if params[:email] and user = User.find_by(reset_password_token: params[:reset_password_token]) and user.email == params[:email]
      user.update_attribute(:password, params[:password])
      render json: { successMessage: 'Password reseted', code: 6, success: true}
    else
      render json: { errorMessage: 'Invalid email', code: 2, success: false}, status: :unauthorized
    end
  end
end
