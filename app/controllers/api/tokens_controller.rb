# Users Controller: JSON response through Active Model Serializers
class Api::TokensController < ApiController
  respond_to :json

  # Token Validation for usage by the frontend in order tocheck for counterfeit Local Storage.
  def create
    if token_by_id == token_by_token
      if token_by_email == token_by_id
        render json: token_by_id, serializer: TokenSerializer, status: 200
      else
        render json: {error: "email and id validation failed"}, status: 404
      end
    else
      render json: {error: "token and id validation failed"}, status: 404
    end
  end

  private

  # Check User ID
  def token_by_id
    User.find(user_params[:id])
  end

  # Check User Email
  def token_by_email
    User.find_by(email: user_params[:email])
  end

  # Check User Authentication Token
  def token_by_token
    User.find_by(authentication_token: user_params[:authenticity_token])
  end

  # Incoming params
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
