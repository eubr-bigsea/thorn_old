class ApplicationController < ActionController::API
  attr_reader :current_user

  protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(@decoded_token['user']['id'])
  rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end


  private

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def decode_token
    @decoded_token ||= JsonWebToken.decode(@http_token)[0]
  end

  def user_id_in_token?
    http_token && decode_token && @decoded_token['user']['id']
  end
end
