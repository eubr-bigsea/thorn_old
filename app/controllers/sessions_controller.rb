# Sessions Controller: Devise Custom Session Controller.
class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |user|
      if request.format.json?
        data = {
          token: user.authentication_token,
          email: user.email,
          userId: user.id,
          locale: user.locale
        }
        render json: data, status: 200 and return
      end
    end
  end
end
