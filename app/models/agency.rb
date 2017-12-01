class Agency < ApplicationRecord
  has_many :notifications, dependent: :destroy

  validates_presence_of :name, :created_by
end
