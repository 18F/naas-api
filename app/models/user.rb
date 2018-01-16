class User < ApplicationRecord
  has_many :user_subscriptions, dependent: :destroy
  has_many :notifications, through: :user_subscriptions
  has_secure_password

  validates_presence_of :email, :last_name, :phone
end
