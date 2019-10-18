class TeamSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description

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

  attribute :users do |object|
    object.users.map do |user|
      {
        id:           user.id,
        full_name:    user.full_name,
        email:        user.email,
        confirmed_at: user.confirmed_at
      }
    end
  end
end
