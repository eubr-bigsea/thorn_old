class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :locale, :profile_picture

  has_many :workflows
  has_many :jobs
  has_many :cards
end
