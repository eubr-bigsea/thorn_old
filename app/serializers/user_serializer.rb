class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name, :full_name, :email, :locale, :confirmed_at

  attribute :roles do |object|
    object.roles.map(&:name)
  end
end
