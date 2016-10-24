require 'jwt'

class JsonWebToken
  @@key = File.read('system/private_key.pem')

  def self.encode data
    payload = data.dup
    payload['exp'] = Time.now.to_i + (24*3600)
    JWT.encode payload, @@key, 'HS512'
  end

  def self.decode token
    JWT.decode token, @@key, true, :algorithm => 'HS512'
  end
end
