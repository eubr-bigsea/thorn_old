class Users::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(params[:user].as_json)
    unless user.save
      render json: {errorMessage: 'Email already registred', code: 3, success: false}, status: :unauthorized
      return
    end
    render json: { successMessage: 'User registred', code: 4, success: true}
    return
  end
end
