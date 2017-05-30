class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :locale, :profile_picture, :authentication_token

  has_many :workflows
  has_many :jobs
end
