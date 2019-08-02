class TokensController < ApplicationController
  respond_to :json

  def create
    user = User.find_by(id: params[:data][:id])

    raise Errors::Unauthorized, {} if user != current_user

    render json: UserSerializer.new(user).to_json
  end
end
