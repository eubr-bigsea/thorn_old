class ProjectSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :category, :subcategory, :description

  attribute :managers do |object|
    object.roles&.first&.users&.map do |manager|
      {
        id:        manager.id,
        full_name: manager.full_name
      }
    end
  end
end
