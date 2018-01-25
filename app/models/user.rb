class User < ApplicationRecord
  has_many :user_subscriptions, dependent: :destroy
  has_many :notifications, through: :user_subscriptions
  has_many :notification_events, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :phone, uniqueness: true
  validates :login_uid, uniqueness: true, if: :login_linked?

  has_secure_password

  def self.from_omniauth(auth)
    login_user = where(email: auth['info']['email']).first_or_create do |user|
      user.login_uid = auth.uid
      user.password = SecureRandom.base64
    end

    login_user.login_uid = auth.uid
    login_user
  end

  def login_linked?
    login_uid.present?
  end
end
