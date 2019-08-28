class Team < ApplicationRecord
  resourcify

  belongs_to :project
  has_and_belongs_to_many :users

  validates :name, uniqueness: true
  validates :name, presence: true
end
