class User < ApplicationRecord
  has_many :user_subscriptions
  has_many :notifications, through: :user_subscriptions

  validates_presence_of :email, :last_name, :phone
end
