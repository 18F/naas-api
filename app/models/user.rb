class User < ApplicationRecord
  has_many :user_subscriptions, dependent: :destroy
  has_many :notifications, through: :user_subscriptions
  has_many :notification_events, dependent: :destroy
  validates :email, uniqueness: true
  validates :phone, uniqueness: true
  has_secure_password

  validates_presence_of :email, :last_name, :phone
end
