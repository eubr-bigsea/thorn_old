class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name, :email, :locale, :confirmed_at

  attribute :full_name do |object|
    "#{object.first_name} #{object.last_name}"
  end

  attribute :is_admin, &:is_admin?
end
