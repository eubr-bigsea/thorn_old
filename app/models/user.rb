class User < ApplicationRecord
  rolify after_add: :make_relation, after_remove: :remove_relation
  include Devise::JWT::RevocationStrategies::Whitelist
  include Searchable
  include Sortable

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { maximum: 30 }

  searchable_by :first_name, :last_name, :email
  has_and_belongs_to_many :monitored_teams, join_table: :monitors_teams,
                          foreign_key: :monitor_id, association_foreign_key: :team_id, class_name: 'Team'
  has_and_belongs_to_many :managed_projects, join_table: :managers_projects, foreign_key: :manager_id,
                          association_foreign_key: :project_id, class_name: 'Project'
  has_and_belongs_to_many :teams

  before_create :skip_confirmation_notification!

  def full_name
    "#{first_name} #{last_name}"
  end

  def send_unlock_instructions
    raw = {}
    send_devise_notification(:unlock_instructions, raw, {})
  end

  def role_of?(role)
    roles.where(name: role).length.positive?
  end

  protected

  def make_relation(role)
    if role.name == 'manager'
      managed_projects << role.resource
    elsif role.name == 'monitor'
      monitored_teams << role.resource
      teams << role.resource
    end
    true
  end

  def remove_relation(role)
    if role.name == 'manager'
      managed_projects.delete(role.resource)
    elsif role.name == 'team'
      monitored_teams.delete(role.resource)
    end
    true
  end
end
