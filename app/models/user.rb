class User < ApplicationRecord
  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationships
  has_many :workflows
  has_many :jobs
  has_and_belongs_to_many :cards

  validates_presence_of :password_confirmation, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { maximum: 72 }, on: :create
  validates :password, length: {minimum: 6}, on: :update, allow_blank: true
  validates :password, length: {maximum: 72}, on: :update, allow_blank: true
  validates :first_name, presence: true, length: {minimum: 2}
  validates :first_name, presence: true, length: {maximum: 30}
  validates :last_name, presence: true, length: {minimum: 2}
  validates :last_name, presence: true, length: {maximum: 30}
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Used when creating users
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  # Generate token.
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
