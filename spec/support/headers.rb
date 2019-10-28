def build_headers(resource: nil)
  hash = {
    'Accept' => 'application/json; charset=utf-8',
    'Content-Type' => 'application/json; charset=utf-8',
  }

  hash = Devise::JWT::TestHelpers.auth_headers(hash, resource) if resource

  hash
end
