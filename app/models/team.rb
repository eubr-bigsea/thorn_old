class Team < ApplicationRecord
  resourcify

  belongs_to :project
  has_and_belongs_to_many :users

  validates :name, uniqueness: { scope: :project_id, case_sensitive: false }
  validates :name, presence: true
end
