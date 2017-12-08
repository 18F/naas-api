class Agency < ApplicationRecord
  has_many :notifications, dependent: :destroy
  has_many :users, through: :notifications
  validates_presence_of :name, :created_by
end
