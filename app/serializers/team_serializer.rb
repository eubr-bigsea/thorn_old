class TeamSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name

  attribute :project do |object|
    {
      id:   object.project.id,
      name: object.project.name
    }
  end

  attribute :leaders do |object|
    object.roles&.first&.users&.map do |leader|
      {
        id:        leader.id,
        full_name: leader.full_name,
        email:     leader.email
      }
    end
  end
end
