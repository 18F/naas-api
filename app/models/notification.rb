class Notification < ApplicationRecord
  belongs_to :agency
  belongs_to :user, optional: true
  validates_presence_of :name
end
