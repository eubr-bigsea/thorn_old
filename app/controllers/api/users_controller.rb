# Users Controller: JSON response through Active Model Serializers
class Api::UsersController < ApiController
  respond_to :json

  # Render all Users using UserSerializer.
  def index
    render json: User.order('display_name ASC').all
  end

  # Render the specified User using UserSerializer.
  def show
    render json: user
  end

  # Render the created User using UserSerializer and the AMS Deserialization.
  def create
    tempUser = User.new(user_params.except(:current_password))
    tempUser.sign_in_count = 0
    if tempUser.save
      render json: tempUser
    else
      render json: ErrorSerializer.serialize(tempUser.errors), status: :unprocessable_entity
    end
  end

  # Render the updated User using UserSerializer and the AMS Deserialization.
  def update
    # Check if password is blank, if so, clear :current_password
    # and update without password, else updates password.
    if current_user.id == user.id
      if user_params[:password].blank? && user_params[:current_password].blank?
        if user.update_without_password(user_params.except(:current_password,:password))
          render json: user, status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      elsif user.update_with_password(user_params)
        render json: user, status: :ok
      else
        render json: ErrorSerializer.serialize(user.errors), status: :unprocessable_entity
      end
    else
      render json: ErrorSerializer.serialize(user.errors), status: :forbidden
    end
  end
  # Destroy User from the AMS Deserialization params.
  def destroy
    render json: {}, status: :method_not_allowed
  end

  private

  # User object from the Deserialization params if there is an id.
  def user
    User.find(params[:id])
  end

  # AMS User Deserialization.
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
