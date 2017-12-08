class User < ApplicationRecord
  has_many :notifications
  has_many :agencies, through: :notifications

  validates_presence_of :email, :last_name, :phone
end
