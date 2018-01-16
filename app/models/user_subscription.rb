class UserSubscription < ApplicationRecord
  has_many :notification_events, dependent: :destroy
  belongs_to :notification
  belongs_to :user
  validates_presence_of :name
end
