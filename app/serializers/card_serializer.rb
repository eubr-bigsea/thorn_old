class CardSerializer < ActiveModel::Serializer
  attributes :id, :category, :title, :link, :content, :updated_at, :created_at
end
