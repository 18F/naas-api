class Notification < ApplicationRecord
  belongs_to :agency
  validates_presence_of :name
end
