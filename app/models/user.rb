class User < ApplicationRecord
  has_many :user_subscriptions
  has_many :notifications, through: :user_subscriptions
  validates :email, presence: true, uniqueness: true
  validates :phone, uniqueness: true
	validates :login_uid, uniqueness: true, if: :login_linked?

  has_secure_password

  def self.from_omniauth(auth)
  	where(email: auth['info']['email']).first_or_create do |user|
  		user.login_uid = auth.uid
  		user.password = SecureRandom.base64
    end
  end


  private

  def login_linked?
    login_uid.present?
  end
end
