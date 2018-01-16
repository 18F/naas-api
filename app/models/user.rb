class User < ApplicationRecord
  has_many :user_subscriptions
  has_many :notifications, through: :user_subscriptions
  validates :email, uniqueness: true
  validates :phone, uniqueness: true
  has_secure_password

  validates_presence_of :email, :last_name, :phone
end
