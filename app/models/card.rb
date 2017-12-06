class Card < ApplicationRecord
  has_and_belongs_to_many :users
  serialize :content, Hash
end
