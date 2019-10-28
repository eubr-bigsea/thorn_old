class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name, :full_name, :email, :locale, :confirmed_at

  attribute :roles do |object|
    [object.roles.first&.name]
  end

  has_many :managed_projects, if: proc { |record| record.managed_projects.any? }, record_type: :project
  has_many :monitored_teams, if: proc { |record| record.monitored_teams.any? }, record_type: :team
  has_many :teams, if: proc { |record| record.teams.any? }
end
