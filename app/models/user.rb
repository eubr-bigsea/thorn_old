class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Whitelist
  include Searchable
  include Sortable

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { maximum: 30 }

  searchable_by :first_name, :last_name, :email

  def full_name
    "#{first_name} #{last_name}"
  end

  def send_unlock_instructions
    raw = {}
    send_devise_notification(:unlock_instructions, raw, {})
  end
end
