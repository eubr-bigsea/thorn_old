class UserAvailableSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name, :full_name, :email
end
