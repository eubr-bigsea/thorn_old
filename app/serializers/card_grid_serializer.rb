class CardGridSerializer < ActiveModel::Serializer
  attributes :id, :configurations
  has_one :user
end
