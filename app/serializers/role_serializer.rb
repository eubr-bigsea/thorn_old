class RoleSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name
end
