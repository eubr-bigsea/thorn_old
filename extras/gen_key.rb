require 'openssl'

rsa_private = OpenSSL::PKey::RSA.generate 4096
key = rsa_private.to_pem.gsub("\n","")
File.open('system/private_key.pem','w') do |f|
  f << key
end
