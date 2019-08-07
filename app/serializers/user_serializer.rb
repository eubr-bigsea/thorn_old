class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name, :email, :locale, :confirmed_at

  attribute :full_name do |object|
    "#{object.first_name} #{object.last_name}"
  end

  attribute :roles do |object|
    object.roles.map(&:name)
  end
end
