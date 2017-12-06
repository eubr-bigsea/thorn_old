class CardSerializer < ActiveModel::Serializer
  attributes :id, :component, :title, :content, :updated_at, :created_at
end
