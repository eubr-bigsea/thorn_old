class Project < ApplicationRecord
  resourcify

  has_many :teams
  has_and_belongs_to_many :managers, join_table: :managers_projects, foreign_key: :project_id,
                          association_foreign_key: :manager_id, class_name: 'User'

  validates :name, uniqueness: true
  validates :name, presence: true
end
