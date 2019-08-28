class Project < ApplicationRecord
  resourcify

  validates :name, uniqueness: true
end
