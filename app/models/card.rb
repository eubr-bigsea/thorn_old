class Card < ApplicationRecord
  serialize :content, Hash
end
