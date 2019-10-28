class ProjectSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :category, :subcategory, :description

  attribute :managers do |object|
    object.roles&.first&.users&.map do |manager|
      {
        id:        manager.id,
        full_name: manager.full_name,
        email:     manager.email
      }
    end
  end

  attribute :teams do |object|
    object.teams.map do |team|
      {
        id:   team.id,
        name: team.name
      }
    end
  end
end
