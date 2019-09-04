class Team < ApplicationRecord
  resourcify

  belongs_to :project
  has_and_belongs_to_many :users

  has_and_belongs_to_many :monitors, join_table: :monitors_teams,
                          association_foreign_key: :monitor_id, foreign_key: :team_id, class_name: 'User'

  validates :name, uniqueness: { scope: :project_id, case_sensitive: false }
  validates :name, presence: true
end
