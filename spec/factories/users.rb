FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    first_name 'MyString'
    middle_name 'MyString'
    last_name 'MyString'
    password 'password'
    sequence(:phone, &:to_s)
    confirmed false

    trait :authenticated do
      sequence :login_uid do |_n|
        SecureRandom.uuid
      end
    end
  end
end
