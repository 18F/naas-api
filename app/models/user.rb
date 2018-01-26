class User < ApplicationRecord
  has_many :user_subscriptions, dependent: :destroy
  has_many :notifications, through: :user_subscriptions
  has_many :notification_events, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  
  validates :login_uid, uniqueness: true, if: :login_linked?

  has_secure_password

  phony_normalize :phone, default_country_code: 'US'
  validates :phone, phony_plausible: true
  
  def self.from_omniauth(auth)
    login_attrs = { phone: auth['extra']['raw_info'].attributes['mfa_phone'].first,
                    email: auth['info']['email'] }

    fuzzy_match = fuzzy_find(login_attrs)
    authenticated_user = fuzzy_match

    unless fuzzy_match
      authenticated_user = create(phone: login_attrs[:phone],
                                  email: login_attrs[:email],
                                  password: SecureRandom.base64)

    end

    authenticated_user.login_uid = auth.uid
    user
  end

  def self.fuzzy_find(attrs={})
    if attrs.has_key? :phone
      phone_user = find_by(phone: PhonyRails.normalize_number(attrs[:phone]))
      return phone_user
    end

    if attrs.has_key? :email
      login_user = find_by(email: attrs[:email])
    end
  end

  def login_linked?
    login_uid.present?
  end
end
