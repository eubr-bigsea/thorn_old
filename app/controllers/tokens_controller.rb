# Users Controller: JSON response through Active Model Serializers
class TokensController < ApplicationController
  respond_to :json

  def create
    user = User.find_by(params[:id])
    render json: UserSerializer.new(user).to_json
  end
end
