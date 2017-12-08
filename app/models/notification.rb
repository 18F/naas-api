class Notification < ApplicationRecord
  belongs_to :agency
  belongs_to :user
  validates_presence_of :name
end
