# Sessions Controller: Devise Custom Session Controller.
class SessionsController < Devise::SessionsController
  respond_to :json

  # Customized Create action. super do |user| kicks in Devise followed by
  # returning JSON only for 200.
  def new
    invalid_login_attempt
  end

  def create
    super do |user|
      if request.format.json?
        data = {
          token: user.authentication_token,
          email: user.email,
          userId: user.id
        }
        render json: data, status: 200 and return
      end
    end
  end

  def invalid_login_attempt
    render json: {success: false, message: "Error with your email or password"}, status: 401
  end

end

