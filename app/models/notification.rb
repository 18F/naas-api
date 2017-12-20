class Notification < ApplicationRecord
  has_many :user_subscriptions, dependent: :destroy
  has_many :users, through: :user_subscriptions
  validates_presence_of :name, :created_by
end
