class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name, :email, :locale

  attribute :full_name do |object|
    "#{object.first_name} #{object.last_name}"
  end
end
