class Project < ApplicationRecord
  resourcify

  has_many :teams

  validates :name, uniqueness: true
  validates :name, presence: true
end
