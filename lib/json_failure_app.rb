class JsonFailureApp < Devise::FailureApp
  def http_auth_body
    return super unless request_format == :json

    code = warden_message == :inactive ? 'missing_confirmation' : 'unknown_credentials'

    error = JE::Unauthorized.new(message: i18n_message, code: code)
    serialized = JE::ErrorSerializer.new(error)
    serialized.to_h.to_json
  end

  def redirect_url
    nil
  end

  def respond
    http_auth
  end
end
