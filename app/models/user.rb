class User < ApplicationRecord
  rolify
  include Devise::JWT::RevocationStrategies::Whitelist

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { maximum: 30 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
