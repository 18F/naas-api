class UserSubscription < ApplicationRecord
  belongs_to :notification
  belongs_to :user
  validates_presence_of :name
end
